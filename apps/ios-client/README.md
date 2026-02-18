# Sharkord iOS Client

A native iOS client for Sharkord, built with SwiftUI.

## Features

- **Dark Theme**: Beautiful dark-themed interface matching Discord aesthetics
- **Text Chat**: Send and receive messages with support for reactions, embeds, and file attachments
- **Voice Channels**: Join voice channels with mute, deafen, and speaking indicators
- **Video Support**: Video calling capabilities in voice channels
- **Server Management**: Browse channels, categories, and server settings
- **User Profiles**: View user profiles and online status
- **Real-time Updates**: WebSocket connection for instant updates
- **Settings**: Comprehensive user and app settings

## Architecture

### Models
- **AppState**: Central app state management
- **Server, Channel, Category**: Server structure models
- **Message, User, Role**: Communication and user models
- **VoiceState**: Voice channel state

### Views
- **ConnectView**: Server connection and authentication
- **ServerView**: Main server interface with channels
- **ChannelContentView**: Text chat and voice channel UI
- **ChannelSidebarView**: Channel list navigation
- **MembersSidebarView**: Online/offline member list
- **VoiceChannelView**: Voice participant grid and controls
- **UserSettingsView**: User preferences and settings
- **UserProfileView**: User profile display

### Services
- **TRPCClient**: WebSocket connection and tRPC communication
- **VoiceService**: WebRTC voice/video handling via Mediasoup
- **FileService**: File upload and download

### Utilities
- **ThemeManager**: Dark theme color palette

## Technology Stack

- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive state management
- **AVFoundation**: Audio/video capture and playback
- **URLSession**: WebSocket connections
- **WebRTC**: Real-time voice/video communication (planned integration)

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Installation

1. Open the project in Xcode
2. Build and run on simulator or device
3. Connect to your Sharkord server using the server URL and access token

## Configuration

The client connects to a Sharkord server via WebSocket. Default configuration:
- Server URL: `ws://localhost:4991`
- Requires access token for authentication

## Development

The iOS client implements the same functionality as the web client:
- tRPC-based API communication
- WebSocket subscriptions for real-time updates
- Mediasoup WebRTC for voice/video
- File attachments and media embeds
- User permissions and roles

## License

MIT License - See LICENSE file for details
