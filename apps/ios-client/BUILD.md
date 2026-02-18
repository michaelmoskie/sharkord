# Sharkord iOS Client - Build Instructions

## Overview
The iOS client is a native SwiftUI application that provides all the functionality of the Sharkord web client with a dark-themed iOS interface.

## Building the App

### Prerequisites
- macOS with Xcode 14.0 or later
- iOS 15.0+ device or simulator
- Active Apple Developer account (for device deployment)

### Using Xcode

1. **Create Xcode Project**
   - Open Xcode
   - File → New → Project
   - Select "iOS" → "App"
   - Product Name: "Sharkord"
   - Organization Identifier: "com.sharkord"
   - Interface: SwiftUI
   - Language: Swift
   - Click "Next" and choose save location

2. **Add Source Files**
   - Copy all `.swift` files from this directory into your Xcode project
   - Ensure files are added to the target
   - Add `Info.plist` to the project

3. **Configure Project Settings**
   - Select project in navigator
   - Set Deployment Target to iOS 15.0
   - Under "Signing & Capabilities":
     - Enable "Automatically manage signing"
     - Select your development team
   - Add capabilities:
     - Background Modes (for audio)
     - Network (for WebSocket connections)

4. **Build and Run**
   - Select your target device or simulator
   - Click the "Run" button (⌘R)

## Project Structure

```
ios-client/
├── SharkordApp.swift          # App entry point
├── ContentView.swift          # Main view router
├── Models/                    # Data models
│   ├── AppState.swift
│   ├── Server.swift
│   ├── Message.swift
│   └── User.swift
├── Views/                     # UI components
│   ├── ConnectView.swift
│   ├── ServerView.swift
│   ├── ChannelContentView.swift
│   ├── ChannelSidebarView.swift
│   ├── VoiceChannelView.swift
│   ├── MembersSidebarView.swift
│   ├── UserProfileView.swift
│   ├── UserSettingsView.swift
│   ├── LoadingView.swift
│   ├── DisconnectedView.swift
│   └── EmojiPickerView.swift
├── Services/                  # Business logic
│   ├── TRPCClient.swift
│   ├── VoiceService.swift
│   └── FileService.swift
└── Utilities/                 # Helpers
    ├── ThemeManager.swift
    ├── Constants.swift
    └── Extensions.swift
```

## Features Implemented

✅ Dark Theme - Discord-like dark interface
✅ Connection Screen - Server URL and token authentication
✅ Text Chat - Messages, reactions, embeds
✅ Voice Channels - Participant grid, mute/deafen controls
✅ Video Support - Camera toggle for video calls
✅ Channel Navigation - Categories and channel list
✅ Members List - Online/offline status, voice indicators
✅ User Profiles - Profile viewing and actions
✅ Settings - Account, profile, privacy, appearance, voice
✅ Real-time WebSocket - tRPC client foundation
✅ File Support - Upload/download service
✅ Emoji Picker - Emoji selection for reactions

## Next Steps for Production

1. **WebRTC Integration**
   - Add WebRTC Swift package
   - Implement Mediasoup client for iOS
   - Connect voice/video to actual streams

2. **tRPC Implementation**
   - Complete tRPC client procedures
   - Add subscription handling
   - Implement auto-reconnection

3. **Persistence**
   - Add CoreData or Realm for offline storage
   - Cache messages and media
   - Store user preferences

4. **Notifications**
   - Implement push notifications
   - Add local notifications for messages
   - Badge count for unread messages

5. **Polish**
   - Add loading states
   - Implement error handling
   - Add animations and transitions
   - Optimize performance

## Testing

The app can be tested in the iOS Simulator or on a physical device. Connect to a running Sharkord server using:
- Server URL: `ws://YOUR_SERVER_IP:4991`
- Access Token: Your server's owner token

## Notes

- All UI is dark-themed by default (enforced via `.preferredColorScheme(.dark)`)
- Uses SwiftUI for modern, declarative UI
- Follows iOS design patterns and best practices
- Ready for App Store submission with additional polish
