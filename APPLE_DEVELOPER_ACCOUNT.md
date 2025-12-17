# How to Get an Apple Developer Account

To publish apps on the App Store, you need to enroll in the **Apple Developer Program**.

## 🍎 Summary
*   **Cost**: $99 USD per year (auto-renewable).
*   **Requirement**: An Apple ID with Two-Factor Authentication enabled.
*   **Output**: Ability to distribute apps to the App Store and TestFlight.

---

## 🚀 The Fastest Way: Use the Apple Developer App
The easiest way to enroll is through the official app on your iPhone, iPad, or Mac.

1.  **Download the App**:
    *   Search for **"Apple Developer"** on the App Store (made by Apple).
    *   [Link to App Store](https://apps.apple.com/us/app/apple-developer/id640199958)

2.  **Sign In**:
    *   Open the app.
    *   Go to the **Account** tab.
    *   Sign in with the Apple ID you want to use for development.

3.  **Start Enrollment**:
    *   Tap **"Enroll Now"**.
    *   Follow the on-screen prompts.
    *   You will be asked to verify your identity (Enter legal name, address, phone).

4.  **Pay**:
    *   The subscription fee ($99/year) will be charged via your standard Apple ID payment method (like an in-app purchase).

5.  **Wait for Activation**:
    *   Often instant, but can take up to 48 hours for verification. You will receive an email when active.

---

## 🌐 Alternative: Enroll via Website
If you cannot use the app, you can enroll via the web, though identity verification might take longer.

1.  Go to [developer.apple.com/enroll](https://developer.apple.com/enroll/).
2.  Click **"Start Your Enrollment"**.
3.  Sign in with your Apple ID.
4.  Select **"Individual / Sole Proprietor"** (if releasing as yourself) or **"Company / Organization"** (requires a D-U-N-S Number).
5.  Fill in your legal details and pay with a credit card.

## ❓ Individual vs Organization
*   **Individual**:
    *   Your personal name appears as the "Seller" on the App Store (e.g., "Deepak Kumar").
    *   No D-U-N-S number needed.
    *   Faster verification.
*   **Organization**:
    *   Your entity name appears as the "Seller" (e.g., "GuestPass Inc.").
    *   Requires a D-U-N-S number and legal entity status (LLC, Corp, etc.).
    *   Takes longer to verify.

## 📧 Using a Separate Email (Recommended)
Yes, you should use a separate Apple ID for development (e.g., `dev@deepakkumar.com` or `deepak.dev@gmail.com`).

1.  **Create a new Apple ID** at [appleid.apple.com](https://appleid.apple.com).
2.  **Enable 2-Factor Authentication** (Required).

### Which account do I use to pay?
If you enroll via the **Apple Developer App**:
1.  Open the Developer App.
2.  Sign in with your **NEW Developer Apple ID** (Account tab).
3.  When you tap "Subscribe":
    *   The payment will be charged to the **Personal Apple ID** currently logged into your iPhone's App Store / iCloud Settings.
    *   **This is OK!** You can pay with your personal money/account. The Developer Membership will still be tied to your **NEW** ID that you signed into the Developer App with.

## 🕵️ Privacy: What is Visible to Users?
When your app is on the App Store, here is what users see:

1.  **Developer Name**:
    *   **Individual**: Your **Legal Name** (e.g., "Deepak Kumar"). You cannot obtain an individual account with a brand name.
    *   **Organization**: Your **Company Name** (e.g., "GuestPass Inc.").
2.  **Your Login Email**: **HIDDEN**. Users never see the Apple ID you use to log in.
3.  **Support Contact**: **VISIBLE**. You must provide a specific Support URL or Email. This **can be different** from your login email.
    *   *Tip: Create a dedicated email like `support@guestpass.com` or `guestpass.app@gmail.com` for this purpose.*

## 🏢 How to Show a Company Name?
To display a brand name (e.g., "GuestPass Inc.") instead of your personal name, you **MUST** enroll as an **Organization**.

1.  **Requirements**:
    *   **Registered Legal Entity**: LLC, Corp, or Ltd. (Sole Proprietorships usually don't qualify).
    *   **D-U-N-S Number**: A standard business identifier (Free).
2.  **Can I switch later?**:
    *   **YES!** You can start as an **Individual** (showing "Deepak Kumar") to launch fast.
    *   Later, if you form an LLC, you can request an **Account Migration** from Apple. Your apps, ratings, and users will transfer seamlessly to the new Organization account.

## ✅ Once Enrolled
Once your account is active:
1.  Go to Xcode > Settings > Accounts.
2.  Sign in with your Developer Apple ID.
3.  You will now see a "Team" appear in your signing settings.
4.  You can now Archive and Upload to the App Store!
