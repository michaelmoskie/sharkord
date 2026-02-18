import Foundation

struct User: Identifiable, Codable {
    let id: String
    let username: String
    let displayName: String?
    let avatar: String?
    let email: String?
    let isOnline: Bool
    let status: UserStatus
    let createdAt: Date
}

enum UserStatus: String, Codable {
    case online
    case away
    case busy
    case offline
}

struct Role: Identifiable, Codable {
    let id: String
    let name: String
    let color: String
    let permissions: [String]
    let serverId: String
    let position: Int
}

struct VoiceState: Codable {
    let userId: String
    let channelId: String?
    let isMuted: Bool
    let isDeafened: Bool
    let isSpeaking: Bool
}
