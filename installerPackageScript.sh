#!/bin/zsh

set -euo pipefail

PASSWORD="$1"



echo "================ A clean up ======================="

[ -d "build" ] && rm -rf "build"

echo "============= make build folder ========="

mkdir -p build

echo "=================== Build Archive of App ================="


xcodebuild archive \
  -project "WireGuard.xcodeproj" \
  -scheme "WireGuardmacOS" \
  -configuration Release \
  -archivePath "build/WireGuardMacOS.xcarchive"



echo "================== copy app bundle to build ============"

ditto build/WireGuardMacOS.xcarchive/Products/Applications/WireGuard.app build/WireGuard.app



rm -r build/WireGuardMacOS.xcarchive

echo "============== unlock login keychain =============="
security unlock-keychain -p "$PASSWORD" ~/Library/Keychains/login.keychain-db

#sudo chown -R $(whoami) WireGuard.app


echo "=========== Signing System Network Extension ==========="

codesign --force --options runtime \
  --entitlements WireGuardSystemNetworkExtensionmacOS/WireGuardSystemNetworkExtensionmacOS.entitlements \
  --sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" \
    build/WireGuard.app/Contents/Library/SystemExtensions/com.watchguard.connectionmanager.network-extension.systemextension

echo "========Verify Network Extension Signed properly or not ? =========="
codesign -dv --entitlements :- \
    build/WireGuard.app/Contents/Library/SystemExtensions/com.watchguard.connectionmanager.network-extension.systemextension

echo "=========== Signing LogIn Item Helper =============="

codesign --force --options runtime \
  --sign  "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" \
  build/WireGuard.app/Contents/Library/LoginItems/WireGuardLoginItemHelper.app



echo "=========== Signing Main App =============="

codesign --force --options runtime \
  --entitlements Sources/WireGuardApp/UI/macOS/WireGuard.entitlements \
  --sign  "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" \
 build/WireGuard.app



#echo "======= Verify Signature =============="
#
#spctl --assess --type execute --verbose build/WireGuard.app

#
#
#codesign --verify --deep --strict --verbose=5 WireGuard.app
#spctl --verbose=4 --assess --type execute WireGuard.app
#
echo "========= zipping ==========="

ditto -c -k --keepParent build/WireGuard.app build/WireGuard.zip

##
##zip -r WireGuard.zip WireGuard.app                (This cmd is not reliable)
##
echo "==============Send to Notarize with wait =============="


xcrun notarytool submit build/WireGuard.zip --keychain-profile "NotaryProfile"  --wait


echo "============= delete zip ==============="

rm -r build/WireGuard.zip

echo "=================== Staple the notarized app ================"

xcrun stapler staple build/WireGuard.app






echo "============ Component Build (raw.pkg)============"

# write pre install and  post install script for package

# Clean staging
rm -rf staging dist
mkdir -p staging/Applications dist


# Copy app (already signed, notarized, stapled)
cp -R build/WireGuard.app staging/Applications/


pkgbuild \
--root "staging" \
--install-location / \
--scripts "package/Scripts" \
--identifier com.watchguard.connectionmanager \
--version 1.0 \
"dist/WireGuard_unsigned.pkg"



 
 
 echo "========== Sign Package with Installer Certificate (.pkg)============"


productbuild \
  --sign "Developer ID Installer: WatchGuard Technologies, Inc. (3TS3WLH98A)" \
  --identifier com.watchguard.connectionmanager \
  --package "dist/WireGuard_unsigned.pkg" \
       "dist/WireGuard_signed.pkg"
      

 
 
echo "============== Notarize Signed Package ==========="

# check notarization status
# if success staple else download log file

submit_output=$(xcrun notarytool submit "dist/WireGuard_signed.pkg" --keychain-profile "NotaryProfile"  --wait)
submit_status=$?

echo "$submit_output"


if [ "$submit_status" -eq 0 ]; then



echo "========================= Package successfully signed ============================"
echo "======================= Now Stapling the Package ============"

xcrun stapler staple "dist/WireGuard_signed.pkg"

else

echo "================= Saving Error Logs ================"

request_id=$(echo "$submit_output" | grep -Eo '[0-9a-fA-F-]{36}' | head -n1)
   
    if [ -n "$request_id" ]; then

          xcrun notarytool log "$request_id" --keychain-profile "NotaryProfile" "dist/developer_log.json" || true
    fi



exit 1

fi


echo "========== ALL DONE ==========="

