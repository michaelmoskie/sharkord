import SwiftUI

struct MembersSidebarView: View {
    let members: [User]
    let voiceStates: [VoiceState]
    
    var onlineMembers: [User] {
        members.filter { $0.isOnline }
    }
    
    var offlineMembers: [User] {
        members.filter { !$0.isOnline }
    }
    
    var body: some View {
        ZStack {
            ThemeManager.backgroundSecondary
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Online members
                    if !onlineMembers.isEmpty {
                        MembersSectionHeader(title: "Online", count: onlineMembers.count)
                        
                        ForEach(onlineMembers) { member in
                            MemberRowView(user: member, voiceState: getVoiceState(for: member.id))
                        }
                    }
                    
                    // Offline members
                    if !offlineMembers.isEmpty {
                        MembersSectionHeader(title: "Offline", count: offlineMembers.count)
                            .padding(.top, 16)
                        
                        ForEach(offlineMembers) { member in
                            MemberRowView(user: member, voiceState: nil)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
    
    private func getVoiceState(for userId: String) -> VoiceState? {
        voiceStates.first { $0.userId == userId }
    }
}

struct MembersSectionHeader: View {
    let title: String
    let count: Int
    
    var body: some View {
        Text("\(title) — \(count)")
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(ThemeManager.textMuted)
            .textCase(.uppercase)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
    }
}

struct MemberRowView: View {
    let user: User
    let voiceState: VoiceState?
    @State private var showingProfile = false
    
    var body: some View {
        Button(action: { showingProfile.toggle() }) {
            HStack(spacing: 12) {
                // Avatar with status
                ZStack(alignment: .bottomTrailing) {
                    Circle()
                        .fill(avatarColor)
                        .frame(width: 32, height: 32)
                        .overlay(
                            Text(user.username.prefix(1).uppercased())
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                        )
                    
                    // Status indicator
                    Circle()
                        .fill(statusColor)
                        .frame(width: 10, height: 10)
                        .overlay(
                            Circle()
                                .stroke(ThemeManager.backgroundSecondary, lineWidth: 2)
                        )
                }
                
                // User info
                VStack(alignment: .leading, spacing: 2) {
                    Text(user.displayName ?? user.username)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(ThemeManager.textPrimary)
                        .lineLimit(1)
                    
                    if let voiceState = voiceState, voiceState.channelId != nil {
                        HStack(spacing: 4) {
                            Image(systemName: "speaker.wave.2.fill")
                                .font(.system(size: 10))
                            Text("In voice")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(ThemeManager.success)
                    }
                }
                
                Spacer()
                
                // Voice indicators
                if let voiceState = voiceState {
                    HStack(spacing: 6) {
                        if voiceState.isMuted {
                            Image(systemName: "mic.slash.fill")
                                .font(.system(size: 14))
                                .foregroundColor(ThemeManager.danger)
                        }
                        
                        if voiceState.isDeafened {
                            Image(systemName: "speaker.slash.fill")
                                .font(.system(size: 14))
                                .foregroundColor(ThemeManager.danger)
                        }
                        
                        if voiceState.isSpeaking {
                            Image(systemName: "waveform")
                                .font(.system(size: 14))
                                .foregroundColor(ThemeManager.success)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.clear)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingProfile) {
            UserProfileView(user: user)
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
        let index = abs(user.id.hashValue) % colors.count
        return colors[index]
    }
    
    private var statusColor: Color {
        switch user.status {
        case .online:
            return ThemeManager.success
        case .away:
            return ThemeManager.warning
        case .busy:
            return ThemeManager.danger
        case .offline:
            return ThemeManager.textMuted
        }
    }
}

#Preview {
    let members = [
        User(id: "1", username: "admin", displayName: "Admin", avatar: nil, email: nil, isOnline: true, status: .online, createdAt: Date()),
        User(id: "2", username: "user1", displayName: "User One", avatar: nil, email: nil, isOnline: true, status: .online, createdAt: Date()),
        User(id: "3", username: "user2", displayName: "User Two", avatar: nil, email: nil, isOnline: false, status: .offline, createdAt: Date())
    ]
    
    return MembersSidebarView(members: members, voiceStates: [])
        .frame(width: 240)
}
