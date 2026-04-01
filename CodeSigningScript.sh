#!/bin/zsh
set -euo pipefail

rm ECommerce.app/Contents/embedded.provisionprofile
cp ~/Downloads/WatchGuard_Developer_ID_Application_CM.provisionprofile ECommerce.app/Contents/embedded.provisionprofile

# rm ECommerce.app/Contents/embedded.provisionprofile
# entitlement path: --entitlements "/Users/SuryanshMishra/Documents/Devlopment_IOSandMacOS/ECommerce/ECommerce/ECommerce.entitlements" \

#find "ECommerce.app/Contents/Resources" -name "*.bundle" -type d -exec \
#codesign --force --timestamp --options runtime \
#--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" {} \;

#codesign --force --timestamp --options runtime \
#--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app/Contents/MacOS/ECommerce"

#
#codesign -s "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" -f --entitlements "/Users/SuryanshMishra/Documents/Devlopment_IOSandMacOS/ECommerce/ECommerce/ECommerce.entitlements" --timestamp -o runtime "ECommerce.app"

codesign --force --timestamp --options runtime \
--entitlements "/Users/SuryanshMishra/Documents/Devlopment_IOSandMacOS/ECommerce/ECommerce/ECommerce.entitlements"  \
--sign  "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app"


#codesign -dvvv ECommerce.app

ditto -c -k --keepParent ECommerce.app ECommerce.zip

xcrun notarytool submit "ECommerce.zip" --keychain-profile "NotaryProfile" --wait

xcrun stapler staple "ECommerce.app"


xcrun stapler validate ECommerce.app

spctl -a -vv ECommerce.app
