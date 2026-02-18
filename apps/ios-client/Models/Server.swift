import Foundation

struct Server: Identifiable, Codable {
    let id: String
    let name: String
    let icon: String?
    let ownerId: String
    let createdAt: Date
    var categories: [Category]
    var channels: [Channel]
    var members: [User]
    var roles: [Role]
}

struct Category: Identifiable, Codable {
    let id: String
    let name: String
    let serverId: String
    let position: Int
    var channels: [Channel]
}

struct Channel: Identifiable, Codable {
    let id: String
    let name: String
    let serverId: String
    let categoryId: String?
    let type: ChannelType
    let position: Int
    let topic: String?
}

enum ChannelType: String, Codable {
    case text
    case voice
    case video
}
