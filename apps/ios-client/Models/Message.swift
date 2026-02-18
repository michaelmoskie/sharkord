import Foundation

struct Message: Identifiable, Codable {
    let id: String
    let content: String
    let authorId: String
    let channelId: String
    let createdAt: Date
    let updatedAt: Date?
    let attachments: [Attachment]?
    let reactions: [Reaction]?
    let embeds: [Embed]?
    let replyToId: String?
    
    var author: User?
}

struct Attachment: Identifiable, Codable {
    let id: String
    let filename: String
    let url: String
    let size: Int
    let contentType: String
}

struct Reaction: Identifiable, Codable {
    let id: String
    let emoji: String
    let count: Int
    let userIds: [String]
}

struct Embed: Codable {
    let type: String
    let title: String?
    let description: String?
    let url: String?
    let imageUrl: String?
    let videoUrl: String?
}
