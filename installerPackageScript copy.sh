#!/bin/zsh
set -euo pipefail





codesign --force --options runtime --timestamp \
--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app/Contents/Frameworks/absl.framework"

codesign --force --options runtime --timestamp \
--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app/Contents/Frameworks/FirebaseAnalytics.framework"

codesign --force --options runtime --timestamp \
--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app/Contents/Frameworks/FirebaseFirestoreInternal.framework"

codesign --force --options runtime --timestamp \
--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app/Contents/Frameworks/GoogleAppMeasurement.framework"

codesign --force --options runtime --timestamp \
--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app/Contents/Frameworks/GoogleAppMeasurementIdentitySupport.framework"

codesign --force --options runtime --timestamp \
--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app/Contents/Frameworks/grpc.framework"

codesign --force --options runtime --timestamp \
--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app/Contents/Frameworks/grpcpp.framework"

codesign --force --options runtime --timestamp \
--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app/Contents/Frameworks/openssl_grpc.framework"

codesign --force --options runtime --timestamp \
--entitlements "/Users/SuryanshMishra/Documents/Devlopment_IOSandMacOS/ECommerce/ECommerce/ECommerce.entitlements" \
--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app"
 

mkdir -p dist

productbuild \
  --component "ECommerce.app" /Applications \
  --identifier "com.watchguard.connectionmanager" \
  --version "1.0" \
  "dist/ECommerce_unsigned.pkg"



productsign \
  --sign "Developer ID Installer: WatchGuard Technologies, Inc. (3TS3WLH98A)" \
  "dist/ECommerce_unsigned.pkg" "dist/ECommerce_signed.pkg"

pkgutil --check-signature "dist/ECommerce_signed.pkg"



xcrun notarytool submit "dist/ECommerce_signed.pkg" --keychain-profile "NotaryProfile" --wait
  

xcrun stapler staple "dist/ECommerce_signed.pkg"

spctl -a -vv --type install "dist/ECommerce_signed.pkg"


