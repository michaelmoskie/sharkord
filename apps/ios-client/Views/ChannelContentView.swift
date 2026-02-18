import SwiftUI

struct ChannelContentView: View {
    let channel: Channel
    @ObservedObject var viewModel: ServerViewModel
    @State private var messageText = ""
    @State private var showingMembers = true
    
    var body: some View {
        ZStack {
            ThemeManager.background
                .ignoresSafeArea()
            
            HStack(spacing: 0) {
                // Main chat area
                VStack(spacing: 0) {
                    // Channel header
                    ChannelHeaderView(channel: channel, toggleMembers: { showingMembers.toggle() })
                    
                    Divider()
                        .background(ThemeManager.borderColor)
                    
                    // Messages area
                    if channel.type == .text {
                        TextChannelView(channel: channel, viewModel: viewModel, messageText: $messageText)
                    } else {
                        VoiceChannelView(channel: channel, viewModel: viewModel)
                    }
                }
                
                // Members sidebar
                if showingMembers {
                    MembersSidebarView(members: viewModel.members, voiceStates: viewModel.voiceStates)
                        .frame(width: 240)
                }
            }
        }
        .onAppear {
            viewModel.loadMessages(for: channel.id)
        }
    }
}

struct ChannelHeaderView: View {
    let channel: Channel
    let toggleMembers: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: channelIcon)
                .font(.system(size: 18))
                .foregroundColor(ThemeManager.textMuted)
            
            Text(channel.name)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(ThemeManager.textPrimary)
            
            if let topic = channel.topic {
                Divider()
                    .frame(height: 20)
                    .background(ThemeManager.borderColor)
                
                Text(topic)
                    .font(.system(size: 14))
                    .foregroundColor(ThemeManager.textMuted)
                    .lineLimit(1)
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {}) {
                    Image(systemName: "bell.fill")
                        .foregroundColor(ThemeManager.textMuted)
                }
                
                Button(action: {}) {
                    Image(systemName: "pin.fill")
                        .foregroundColor(ThemeManager.textMuted)
                }
                
                Button(action: toggleMembers) {
                    Image(systemName: "person.2.fill")
                        .foregroundColor(ThemeManager.textMuted)
                }
                
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(ThemeManager.textMuted)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(ThemeManager.background)
    }
    
    private var channelIcon: String {
        switch channel.type {
        case .text:
            return "number"
        case .voice:
            return "speaker.wave.2.fill"
        case .video:
            return "video.fill"
        }
    }
}

struct TextChannelView: View {
    let channel: Channel
    @ObservedObject var viewModel: ServerViewModel
    @Binding var messageText: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Messages list
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.messages) { message in
                            MessageRowView(message: message)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
            }
            
            Divider()
                .background(ThemeManager.borderColor)
            
            // Message input
            MessageInputView(messageText: $messageText, onSend: {
                guard !messageText.isEmpty else { return }
                viewModel.sendMessage(content: messageText, channelId: channel.id)
                messageText = ""
            })
        }
    }
}

struct MessageRowView: View {
    let message: Message
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Avatar
            Circle()
                .fill(avatarColor)
                .frame(width: 40, height: 40)
                .overlay(
                    Text(message.author?.username.prefix(1).uppercased() ?? "?")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                // Author and timestamp
                HStack(spacing: 8) {
                    Text(message.author?.displayName ?? message.author?.username ?? "Unknown")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Text(formatDate(message.createdAt))
                        .font(.system(size: 12))
                        .foregroundColor(ThemeManager.textMuted)
                }
                
                // Message content
                Text(message.content)
                    .font(.system(size: 15))
                    .foregroundColor(ThemeManager.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Reactions
                if let reactions = message.reactions, !reactions.isEmpty {
                    HStack(spacing: 4) {
                        ForEach(reactions) { reaction in
                            ReactionView(reaction: reaction)
                        }
                    }
                    .padding(.top, 4)
                }
            }
            
            Spacer()
        }
    }
    
    private var avatarColor: Color {
        let colors: [Color] = [
            ThemeManager.accent,
            ThemeManager.success,
            ThemeManager.warning,
            Color(hex: "#9b59b6"),
            Color(hex: "#e91e63")
        ]
        let index = abs(message.authorId.hashValue) % colors.count
        return colors[index]
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}

struct ReactionView: View {
    let reaction: Reaction
    
    var body: some View {
        HStack(spacing: 4) {
            Text(reaction.emoji)
                .font(.system(size: 14))
            Text("\(reaction.count)")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(ThemeManager.textSecondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(ThemeManager.backgroundSecondary)
        .cornerRadius(8)
    }
}

struct MessageInputView: View {
    @Binding var messageText: String
    let onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {}) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(ThemeManager.textMuted)
            }
            
            HStack {
                TextField("", text: $messageText)
                    .placeholder(when: messageText.isEmpty) {
                        Text("Message...")
                            .foregroundColor(ThemeManager.textMuted)
                    }
                    .foregroundColor(ThemeManager.textPrimary)
                    .onSubmit(onSend)
                
                HStack(spacing: 8) {
                    Button(action: {}) {
                        Image(systemName: "face.smiling")
                            .foregroundColor(ThemeManager.textMuted)
                    }
                    
                    if !messageText.isEmpty {
                        Button(action: onSend) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(ThemeManager.accent)
                        }
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(ThemeManager.channelBackground)
            .cornerRadius(8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    let viewModel = ServerViewModel()
    let channel = Channel(id: "1", name: "general", serverId: "1", categoryId: "1", type: .text, position: 0, topic: "General discussion")
    
    return ChannelContentView(channel: channel, viewModel: viewModel)
        .environmentObject(AppState())
        .onAppear {
            viewModel.loadServerData()
            viewModel.loadMessages(for: channel.id)
        }
}
