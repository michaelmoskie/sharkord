import SwiftUI

struct VoiceChannelView: View {
    let channel: Channel
    @ObservedObject var viewModel: ServerViewModel
    @State private var isConnected = false
    @State private var isMuted = false
    @State private var isDeafened = false
    @State private var isCameraOn = false
    
    var connectedUsers: [User] {
        let voiceUserIds = viewModel.voiceStates
            .filter { $0.channelId == channel.id }
            .map { $0.userId }
        return viewModel.members.filter { voiceUserIds.contains($0.id) }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Voice participants grid
            if !connectedUsers.isEmpty || isConnected {
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(connectedUsers) { user in
                            VoiceParticipantCard(user: user, voiceState: getVoiceState(for: user.id))
                        }
                    }
                    .padding()
                }
            } else {
                // Empty state
                VStack(spacing: 24) {
                    Spacer()
                    
                    Image(systemName: "speaker.wave.2.fill")
                        .font(.system(size: 60))
                        .foregroundColor(ThemeManager.textMuted)
                    
                    Text("No one is in this voice channel")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Text("Join the voice channel to start talking")
                        .font(.system(size: 14))
                        .foregroundColor(ThemeManager.textSecondary)
                    
                    Spacer()
                }
            }
            
            Divider()
                .background(ThemeManager.borderColor)
            
            // Voice controls
            VoiceControlsView(
                isConnected: $isConnected,
                isMuted: $isMuted,
                isDeafened: $isDeafened,
                isCameraOn: $isCameraOn,
                channelType: channel.type
            )
        }
    }
    
    private func getVoiceState(for userId: String) -> VoiceState? {
        viewModel.voiceStates.first { $0.userId == userId && $0.channelId == channel.id }
    }
}

struct VoiceParticipantCard: View {
    let user: User
    let voiceState: VoiceState?
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                // Video placeholder or avatar
                RoundedRectangle(cornerRadius: 12)
                    .fill(ThemeManager.backgroundSecondary)
                    .aspectRatio(16/9, contentMode: .fit)
                    .overlay(
                        Circle()
                            .fill(avatarColor)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Text(user.username.prefix(1).uppercased())
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                            )
                    )
                
                // Speaking indicator
                if voiceState?.isSpeaking == true {
                    Circle()
                        .fill(ThemeManager.success)
                        .frame(width: 12, height: 12)
                        .padding(8)
                }
            }
            
            HStack(spacing: 6) {
                Text(user.displayName ?? user.username)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(ThemeManager.textPrimary)
                    .lineLimit(1)
                
                if voiceState?.isMuted == true {
                    Image(systemName: "mic.slash.fill")
                        .font(.system(size: 12))
                        .foregroundColor(ThemeManager.danger)
                }
                
                if voiceState?.isDeafened == true {
                    Image(systemName: "speaker.slash.fill")
                        .font(.system(size: 12))
                        .foregroundColor(ThemeManager.danger)
                }
            }
        }
        .padding(12)
        .background(ThemeManager.backgroundTertiary)
        .cornerRadius(12)
    }
    
    private var avatarColor: Color {
        let colors: [Color] = [
            ThemeManager.accent,
            ThemeManager.success,
            ThemeManager.warning,
            Color(hex: "#9b59b6"),
            Color(hex: "#e91e63")
        ]
        let index = abs(user.id.hashValue) % colors.count
        return colors[index]
    }
}

struct VoiceControlsView: View {
    @Binding var isConnected: Bool
    @Binding var isMuted: Bool
    @Binding var isDeafened: Bool
    @Binding var isCameraOn: Bool
    let channelType: ChannelType
    
    var body: some View {
        VStack(spacing: 12) {
            if isConnected {
                // Active call controls
                HStack(spacing: 20) {
                    ControlButton(
                        icon: isMuted ? "mic.slash.fill" : "mic.fill",
                        label: isMuted ? "Unmute" : "Mute",
                        isActive: isMuted,
                        color: isMuted ? ThemeManager.danger : ThemeManager.textSecondary
                    ) {
                        isMuted.toggle()
                    }
                    
                    ControlButton(
                        icon: isDeafened ? "speaker.slash.fill" : "speaker.wave.2.fill",
                        label: isDeafened ? "Undeafen" : "Deafen",
                        isActive: isDeafened,
                        color: isDeafened ? ThemeManager.danger : ThemeManager.textSecondary
                    ) {
                        isDeafened.toggle()
                    }
                    
                    if channelType == .video {
                        ControlButton(
                            icon: isCameraOn ? "video.fill" : "video.slash.fill",
                            label: isCameraOn ? "Camera On" : "Camera Off",
                            isActive: !isCameraOn,
                            color: isCameraOn ? ThemeManager.success : ThemeManager.textSecondary
                        ) {
                            isCameraOn.toggle()
                        }
                    }
                    
                    ControlButton(
                        icon: "phone.down.fill",
                        label: "Disconnect",
                        isActive: false,
                        color: ThemeManager.danger
                    ) {
                        isConnected = false
                        isMuted = false
                        isDeafened = false
                        isCameraOn = false
                    }
                }
            } else {
                // Join button
                Button(action: { isConnected = true }) {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("Join Voice")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ThemeManager.success)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.vertical, 12)
        .background(ThemeManager.backgroundTertiary)
    }
}

struct ControlButton: View {
    let icon: String
    let label: String
    let isActive: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(isActive ? color.opacity(0.2) : ThemeManager.backgroundSecondary)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(color)
                }
                
                Text(label)
                    .font(.system(size: 12))
                    .foregroundColor(ThemeManager.textSecondary)
            }
        }
    }
}

#Preview {
    let viewModel = ServerViewModel()
    let channel = Channel(id: "3", name: "General Voice", serverId: "1", categoryId: "2", type: .voice, position: 0, topic: nil)
    
    return VoiceChannelView(channel: channel, viewModel: viewModel)
        .onAppear {
            viewModel.loadServerData()
        }
}
