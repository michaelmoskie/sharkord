import SwiftUI

struct ServerView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = ServerViewModel()
    @State private var showingSettings = false
    @State private var showingSidebar = true
    
    var body: some View {
        NavigationView {
            // Left sidebar with channels
            if showingSidebar {
                ChannelSidebarView(viewModel: viewModel)
                    .frame(width: 280)
            }
            
            // Main content area
            if let channel = appState.currentChannel {
                ChannelContentView(channel: channel, viewModel: viewModel)
            } else {
                WelcomeView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .background(ThemeManager.backgroundTertiary)
        .preferredColorScheme(.dark)
        .onAppear {
            viewModel.loadServerData()
        }
    }
}

struct WelcomeView: View {
    var body: some View {
        ZStack {
            ThemeManager.background
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .font(.system(size: 60))
                    .foregroundColor(ThemeManager.accent)
                
                Text("Welcome to Sharkord")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(ThemeManager.textPrimary)
                
                Text("Select a channel to get started")
                    .font(.system(size: 16))
                    .foregroundColor(ThemeManager.textSecondary)
            }
        }
    }
}

class ServerViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var channels: [Channel] = []
    @Published var messages: [Message] = []
    @Published var members: [User] = []
    @Published var voiceStates: [VoiceState] = []
    
    func loadServerData() {
        // Mock data for demonstration
        categories = [
            Category(id: "1", name: "Text Channels", serverId: "server1", position: 0, channels: []),
            Category(id: "2", name: "Voice Channels", serverId: "server1", position: 1, channels: [])
        ]
        
        channels = [
            Channel(id: "1", name: "general", serverId: "server1", categoryId: "1", type: .text, position: 0, topic: "General discussion"),
            Channel(id: "2", name: "announcements", serverId: "server1", categoryId: "1", type: .text, position: 1, topic: "Important announcements"),
            Channel(id: "3", name: "General Voice", serverId: "server1", categoryId: "2", type: .voice, position: 0, topic: nil),
            Channel(id: "4", name: "Gaming", serverId: "server1", categoryId: "2", type: .voice, position: 1, topic: nil)
        ]
        
        members = [
            User(id: "1", username: "admin", displayName: "Admin", avatar: nil, email: nil, isOnline: true, status: .online, createdAt: Date()),
            User(id: "2", username: "user1", displayName: "User One", avatar: nil, email: nil, isOnline: true, status: .online, createdAt: Date()),
            User(id: "3", username: "user2", displayName: "User Two", avatar: nil, email: nil, isOnline: false, status: .offline, createdAt: Date())
        ]
    }
    
    func loadMessages(for channelId: String) {
        // Mock messages
        messages = [
            Message(id: "1", content: "Welcome to Sharkord!", authorId: "1", channelId: channelId, createdAt: Date().addingTimeInterval(-3600), updatedAt: nil, attachments: nil, reactions: nil, embeds: nil, replyToId: nil, author: members.first),
            Message(id: "2", content: "This is a self-hosted communication platform", authorId: "2", channelId: channelId, createdAt: Date().addingTimeInterval(-1800), updatedAt: nil, attachments: nil, reactions: nil, embeds: nil, replyToId: nil, author: members[1]),
            Message(id: "3", content: "You can chat, share files, and join voice channels!", authorId: "1", channelId: channelId, createdAt: Date().addingTimeInterval(-900), updatedAt: nil, attachments: nil, reactions: nil, embeds: nil, replyToId: nil, author: members.first)
        ]
    }
    
    func sendMessage(content: String, channelId: String) {
        let newMessage = Message(
            id: UUID().uuidString,
            content: content,
            authorId: "1",
            channelId: channelId,
            createdAt: Date(),
            updatedAt: nil,
            attachments: nil,
            reactions: nil,
            embeds: nil,
            replyToId: nil,
            author: members.first
        )
        messages.append(newMessage)
    }
}

#Preview {
    ServerView()
        .environmentObject(AppState())
        .environmentObject(ThemeManager())
}
