# How to Distribution Your App to the App Store

Your app `GuestPassQR` is effectively "Prod Ready". Follow these steps to upload it to the iOS App Store and Mac App Store.

## 1. Prerequisites
*   An active **Apple Developer Program** membership.
*   **App Store Connect** record created for your app (Log in to App Store Connect and create a new App with Bundle ID: `com.guestpass.qr`).

## 2. Prepare Project Settings (Important!)

We previously disabled "Hardened Runtime" for local macOS testing. You **must** re-enable it for the Mac App Store.

1.  Open `GuestPassQR.xcodeproj` in Xcode.
2.  Select the **GuestPassQR** target in the project editor.
3.  Go to **Signing & Capabilities**.
4.  **Signing (All)**: Use "Automatically manage signing" and select your Team.
5.  **Hardened Runtime (macOS)**: 
    *   Click the `+ Capability` button.
    *   Search for "Hardened Runtime" and add it. 
    *   *(Note: This is required for Mac App Store/Notarization).*

## 3. Set Version
1.  In the **General** tab under "Identity":
    *   **Version**: e.g., `1.0.0`
    *   **Build**: e.g., `1` (Increment this for every upload).

## 4. Archive and Upload

### For iOS
1.  Select standard destination **Any iOS Device (arm64)** from the toolbar top menu.
2.  Go to Menu: **Product** > **Archive**.
3.  Wait for the build to finish. The "Organizer" window will open.
4.  Select your archive and click **Distribute App**.
5.  Select **App Store Connect** > **Upload** > **Next**.
6.  Follow the prompts (Keep "Manage Version and Build Number" checked).
7.  Click **Upload**.

### For macOS
1.  Select destination **Any Mac (Mac Catalyst, Native, or My Mac)**. Ensure it says "Any Mac" or your mac's name.
2.  Go to Menu: **Product** > **Archive**.
3.  In the Organizer, select the Mac archive.
4.  Click **Distribute App**.
5.  Select **App Store Connect** > **Upload**.
6.  Follow the prompts and **Upload**.

## 5. Metadata and Review
1.  Go to [App Store Connect](https://appstoreconnect.apple.com).
2.  Select your app.
3.  Under **TestFlight**, you should see your uploaded build processing (takes 10-20 mins).
4.  Fill in your App Information (Screenshots, Description, Keywords, Support URL).
    *   *Tip: Use the screenshots from your Simulator.*
5.  Select the build you uploaded.
6.  Click **Add for Review**.

## 6. Troubleshooting
*   **"Missing Compliance"**: If asked about Encryption, select "Yes" (Standard Encryption) or "No" depending on your usage. Since this app uses standard HTTPS/WiFi APIs, usually "No" or "Exempt" is sufficient unless you added custom crypto libraries. HTTPS is exempt.
*   **"Asset Validation Failed"**: Check if your App Icons are correct (we generated them, so they should be).
