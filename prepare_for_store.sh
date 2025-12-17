#!/bin/bash

echo "🚀 Preparing GuestPass for App Store Submission..."

# 1. Enable Hardened Runtime in Xcode Project (Required for macOS)
# We use sed to flip NO to YES for ENABLE_HARDENED_RUNTIME
sed -i '' 's/ENABLE_HARDENED_RUNTIME\[sdk=macosx\*\]" = NO;/ENABLE_HARDENED_RUNTIME[sdk=macosx*]" = YES;/g' GuestPassQR.xcodeproj/project.pbxproj
echo "✅ Enabled Hardened Runtime"

# 2. Restore Entitlements (Required for WiFi & Mac Sandbox)
# Overwriting GuestPassQR.entitlements with the correct production values
cat <<EOF > GuestPassQR/GuestPassQR.entitlements
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.developer.networking.HotspotConfiguration</key>
    <true/>
    <key>com.apple.developer.networking.wifi-info</key>
    <true/>
    <key>com.apple.security.app-sandbox</key>
    <true/>
    <key>com.apple.security.files.user-selected.read-write</key>
    <true/>
</dict>
</plist>
EOF
echo "✅ Restored Entitlements (WiFi, Hotspot, Sandbox)"

# 3. Commit changes (Optional, but good practice)
git add GuestPassQR.xcodeproj/project.pbxproj GuestPassQR/GuestPassQR.entitlements
git commit -m "Configure for App Store: Enable Hardened Runtime & Restore Entitlements"

echo "🎉 READY! Open Xcode -> Product -> Archive to submit."
