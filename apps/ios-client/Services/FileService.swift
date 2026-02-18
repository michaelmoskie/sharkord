import Foundation

class FileService {
    static let shared = FileService()
    
    private init() {}
    
    func uploadFile(_ fileURL: URL, to channelId: String) async throws -> Attachment {
        // Implementation would upload file to server
        // Returns attachment metadata
        
        let fileData = try Data(contentsOf: fileURL)
        let filename = fileURL.lastPathComponent
        let contentType = mimeType(for: fileURL)
        
        // Mock response
        return Attachment(
            id: UUID().uuidString,
            filename: filename,
            url: fileURL.absoluteString,
            size: fileData.count,
            contentType: contentType
        )
    }
    
    func downloadFile(_ attachment: Attachment) async throws -> URL {
        // Implementation would download file from server
        // Returns local file URL
        
        guard let url = URL(string: attachment.url) else {
            throw NSError(domain: "FileService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        let (localURL, _) = try await URLSession.shared.download(from: url)
        return localURL
    }
    
    private func mimeType(for url: URL) -> String {
        let pathExtension = url.pathExtension
        
        switch pathExtension.lowercased() {
        case "jpg", "jpeg":
            return "image/jpeg"
        case "png":
            return "image/png"
        case "gif":
            return "image/gif"
        case "mp4":
            return "video/mp4"
        case "pdf":
            return "application/pdf"
        case "txt":
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
}
