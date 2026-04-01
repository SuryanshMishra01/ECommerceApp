#!/bin/zsh
set -euo pipefail

APP_NAME="ECommerce"
PROJECT="ECommerce.xcodeproj"
SCHEME="ECommerce"
CONFIGURATION="Release"

BUILD_DIR="build"
ARCHIVE_PATH="$BUILD_DIR/${APP_NAME}.xcarchive"
APP_PATH="$BUILD_DIR/${APP_NAME}.app"
APP_ENTITLEMENTS_PATH="ECommerce/ECommerce.entitlements"
ZIP_PATH="$BUILD_DIR/${APP_NAME}.zip"

STAGING_DIR="staging"
DIST_DIR="dist"

BUNDLE_ID="com.watchguard.connectionmanager"
PKG_IDENTIFIER="com.watchguard.connectionmanager"

APP_SIGN_IDENTITY="Developer ID Application: WatchGuard Technologies, Inc. (3TS3WLH98A)"
PKG_SIGN_IDENTITY="Developer ID Installer: WatchGuard Technologies, Inc. (3TS3WLH98A)"
NOTARY_PROFILE="NotaryProfile"

notarize_and_check() {
  local item_path="$1"
  local label="$2"
  local output submission_id

  echo "=== Notarizing ${label} ==="
  output="$(xcrun notarytool submit "$item_path" --keychain-profile "$NOTARY_PROFILE" --wait 2>&1 || true)"
  echo "$output"

  if echo "$output" | grep -qE 'status: Accepted|Current status: Accepted'; then
    return 0
  fi

  submission_id="$(echo "$output" | grep -Eo '[0-9a-fA-F-]{36}' | head -n1 || true)"
  if [[ -n "$submission_id" ]]; then
    echo "=== Fetching notarization log for ${label} ==="
    xcrun notarytool log "$submission_id" --keychain-profile "$NOTARY_PROFILE" "${BUILD_DIR}/${APP_NAME}_${label}_notary_log.json" || true
  fi

  echo "Notarization failed for ${label}"
  return 1
}

echo "================ Cleanup ================"
rm -rf "$BUILD_DIR" "$STAGING_DIR" "$DIST_DIR"
mkdir -p "$BUILD_DIR" "$STAGING_DIR/Applications" "$DIST_DIR"


echo "================ Archive app ================"
xcodebuild archive \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -configuration "$CONFIGURATION" \
  -archivePath "$ARCHIVE_PATH"

echo "================ Copy archived app ================"
ditto "$ARCHIVE_PATH/Products/Applications/${APP_NAME}.app" "$APP_PATH"


echo "================ Replace Provisioning Profile ================"

rm "$APP_PATH/Contents/embedded.provisionprofile"
cp ~/Downloads/WatchGuard_Developer_ID_Application_CM.provisionprofile "$APP_PATH/Contents/embedded.provisionprofile"

echo "============= Sign main app (with entitlements) ================"

codesign --force --timestamp --options runtime  \
--entitlements "$APP_ENTITLEMENTS_PATH" \
--sign "$APP_SIGN_IDENTITY" "$APP_PATH"
 
# codesign -s "$APP_SIGN_IDENTITY" -f \
# --entitlements "$APP_ENTITLEMENTS_PATH" \
# --timestamp -o runtime "$APP_PATH"
# 
 echo "================ Verify app signature ================"
codesign --verify --deep --strict --verbose=4 "$APP_PATH"

echo "===================== Inspect Sign Details ==================="
codesign -dv --verbose=4 "$APP_PATH"

#
#echo " ========= Check entitlements only on app ============ "
#codesign -d --entitlements :- "$APP_PATH"
#
#echo " ================== Check a Framework =================== "
#codesign -d --entitlements :- "$APP_PATH/Contents/Frameworks/absl.framework"
# 

#
# Optional only if you intentionally change the app after archive.
# In the normal case, Xcode already signed the archive correctly.
# If you do re-sign here, do it only once, after all bundle changes are complete.
# codesign --force --options runtime --timestamp --sign "$APP_SIGN_IDENTITY" "$APP_PATH"

#echo "================ Zip app for notarization ================"
#ditto -c -k --keepParent "$APP_PATH" "$ZIP_PATH"
#
#if ! notarize_and_check "$ZIP_PATH" "app_zip"; then
#  exit 1
#fi
#
#echo "================ Staple app ================"
#xcrun stapler staple "$APP_PATH"


echo "================ Build installer staging ================"
rm -rf "$STAGING_DIR" "$DIST_DIR"
mkdir -p "$STAGING_DIR/Applications" "$DIST_DIR"
ditto "$APP_PATH" "$STAGING_DIR/Applications/${APP_NAME}.app"

echo "================ Build unsigned pkg ================"

productbuild \
  --component "$APP_PATH" /Applications \
  --identifier "$PKG_IDENTIFIER" \
  --version "1.0" \
 "$DIST_DIR/${APP_NAME}.unsigned.pkg"



echo "================ Sign pkg ================"
productsign \
  --sign "$PKG_SIGN_IDENTITY" \
  "$DIST_DIR/${APP_NAME}.unsigned.pkg" \
  "$DIST_DIR/${APP_NAME}.signed.pkg"

echo "================ Verify pkg signature ================"
pkgutil --check-signature "$DIST_DIR/${APP_NAME}.signed.pkg"

echo "================ Notarize signed pkg ================"
if ! notarize_and_check "$DIST_DIR/${APP_NAME}.signed.pkg" "pkg"; then
  exit 1
fi

echo "================ Staple pkg ================"
xcrun stapler staple "$DIST_DIR/${APP_NAME}.signed.pkg"

echo "================ Final validation ================"
spctl -a -vv --type install "$DIST_DIR/${APP_NAME}.signed.pkg"

echo "================ ALL DONE ================"

