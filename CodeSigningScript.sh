#!/bin/zsh
set -euo pipefail

CERT="Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)"
APP="ECommerce.app"

# rm ECommerce.app/Contents/embedded.provisionprofile

find "ECommerce.app/Contents/Resources" -name "*.bundle" -type d -exec \
codesign --force --timestamp --options runtime \
--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" {} \;

#codesign --force --timestamp --options runtime \
#--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app/Contents/MacOS/ECommerce"


codesign --force \
--timestamp \
--options runtime \
--entitlements "/Users/SuryanshMishra/Documents/Devlopment_IOSandMacOS/ECommerce/ECommerce/ECommerce.entitlements" \
--sign "Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)" "ECommerce.app"

codesign -dvvv ECommerce.app

ditto -c -k --keepParent ECommerce.app dist/ECommerce.zip

xcrun notarytool submit "dist/ECommerce.zip" --keychain-profile "NotaryProfile" --wait

xcrun stapler staple "ECommerce.app"


xcrun stapler validate ECommerce.app

spctl -a -vv ECommerce.app
