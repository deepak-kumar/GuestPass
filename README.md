# Guest Pass QR

A beautiful iOS and macOS app that generates WiFi QR codes for easy network sharing.

## Features

✨ **Instant WiFi Sharing** - Generate QR codes that allow users to join your WiFi network by simply scanning - no manual password entry required!

🎯 **Auto WiFi Detection** - Automatically detects and prefills your current WiFi network details

🎨 **Minimalistic Design** - Clean, full-screen interface with simple dark theme

⚡ **Streamlined UX** - Just 2 fields (Network & Password) with smart defaults

📱 **Universal App** - Works on both iPhone/iPad and Mac

🔒 **Security Support** - Supports WPA/WPA2/WPA3 and open networks

🚀 **App Store Ready** - Includes professional app icons, launch screen, and privacy configurations

✨ **One-Tap Generation** - Minimal clicks to generate your QR code

## How It Works

The app generates QR codes using the standard WiFi configuration format:
```
WIFI:T:<security_type>;S:<ssid>;P:<password>;H:<hidden>;;
```

When scanned with an iPhone or iPad camera (iOS 11+), the device will automatically prompt to join the network - no additional apps needed!

## Usage

1. **Open the app** on your iPhone, iPad, or Mac
2. **Network auto-detected** - Your current WiFi network is automatically filled in
3. **Enter password** - Just type your WiFi password
4. **Choose security** - Tap WPA (default) or Open for networks without passwords
5. **Tap "Generate QR Code"**
6. **Share with guests** - They scan it with their camera to instantly connect!

## Building the App

### Requirements
- Xcode 15.0 or later
- iOS 17.0+ / macOS 14.0+
- Swift 5.9+

### Build Instructions

1. Open `GuestPassQR.xcodeproj` in Xcode
2. Select your target device (iPhone Simulator, iPad Simulator, or Mac)
3. Press `Cmd + R` to build and run

Or use the command line:

```bash
# For iOS Simulator
xcodebuild -project GuestPassQR.xcodeproj -scheme GuestPassQR -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 15 Pro' build

# For macOS
xcodebuild -project GuestPassQR.xcodeproj -scheme GuestPassQR -sdk macosx build
```

## Technical Details

### Architecture
- **SwiftUI** - Modern declarative UI framework
- **Core Image** - High-quality QR code generation with error correction
- **Multiplatform** - Shared codebase for iOS and macOS

### QR Code Format
The app follows the [ZXing WiFi QR Code format](https://github.com/zxing/zxing/wiki/Barcode-Contents#wi-fi-network-config-android-ios-11), which is the industry standard supported by iOS, Android, and most QR code readers.

### Security
- Passwords are never stored or transmitted
- QR codes are generated locally on-device
- All data stays on your device

## Design Highlights

- **Minimalistic Interface** - Clean, distraction-free full-screen design
- **Simple Dark Theme** - Easy on the eyes with subtle backgrounds
- **Auto WiFi Detection** - Smart prefilling of network details
- **Streamlined Inputs** - Only essential fields, no clutter
- **Fast Animations** - Quick, smooth transitions
- **SF Symbols** - Native iOS/macOS icons for consistency

## Compatibility

### Scanning the QR Code
- **iOS 11+** - Native camera app support
- **Android 10+** - Native camera app support
- **Older devices** - Use any QR code reader app

### Running the App
- **iOS** - iPhone and iPad running iOS 17.0 or later
- **macOS** - Mac running macOS 14.0 (Sonoma) or later

## License

This project is open source and available for personal and commercial use.

## Support

For issues or questions, please open an issue on the repository.

---

**Made with ❤️ using SwiftUI**
