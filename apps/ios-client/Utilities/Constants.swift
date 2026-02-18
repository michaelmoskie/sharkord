import Foundation

struct Constants {
    // API Configuration
    static let defaultServerURL = "ws://localhost:4991"
    static let apiTimeout: TimeInterval = 30
    
    // WebSocket
    static let reconnectDelay: TimeInterval = 5
    static let maxReconnectAttempts = 5
    
    // Voice
    static let voiceMaxParticipants = 25
    static let audioSampleRate: Double = 48000
    static let audioBitrate = 64000
    
    // Files
    static let maxFileSize = 10 * 1024 * 1024 // 10MB
    static let allowedImageTypes = ["image/jpeg", "image/png", "image/gif", "image/webp"]
    static let allowedVideoTypes = ["video/mp4", "video/webm"]
    
    // UI
    static let messagePageSize = 50
    static let typingIndicatorTimeout: TimeInterval = 3
    static let avatarSize: CGFloat = 40
    static let compactAvatarSize: CGFloat = 32
}
