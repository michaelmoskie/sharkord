import SwiftUI

struct ChannelSidebarView: View {
    @ObservedObject var viewModel: ServerViewModel
    @EnvironmentObject var appState: AppState
    @State private var showingUserSettings = false
    
    var body: some View {
        ZStack {
            ThemeManager.backgroundSecondary
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Server header
                HStack {
                    Text("My Server")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Spacer()
                    
                    Button(action: { showingUserSettings.toggle() }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(ThemeManager.textSecondary)
                    }
                }
                .padding()
                .background(ThemeManager.backgroundTertiary)
                
                Divider()
                    .background(ThemeManager.borderColor)
                
                // Channels list
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(getCategorizedChannels(), id: \.category.id) { item in
                            CategorySection(category: item.category, channels: item.channels)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                // User panel at bottom
                UserPanelView()
            }
        }
        .sheet(isPresented: $showingUserSettings) {
            UserSettingsView()
        }
    }
    
    private func getCategorizedChannels() -> [(category: Category, channels: [Channel])] {
        viewModel.categories.map { category in
            let categoryChannels = viewModel.channels.filter { $0.categoryId == category.id }
            return (category: category, channels: categoryChannels)
        }
    }
}

struct CategorySection: View {
    let category: Category
    let channels: [Channel]
    @State private var isExpanded = true
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Category header
            Button(action: { isExpanded.toggle() }) {
                HStack {
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(ThemeManager.textMuted)
                    
                    Text(category.name.uppercased())
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(ThemeManager.textMuted)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            
            // Channels
            if isExpanded {
                ForEach(channels) { channel in
                    ChannelRowView(channel: channel)
                }
            }
        }
    }
}

struct ChannelRowView: View {
    let channel: Channel
    @EnvironmentObject var appState: AppState
    
    var isSelected: Bool {
        appState.currentChannel?.id == channel.id
    }
    
    var body: some View {
        Button(action: {
            appState.currentChannel = channel
        }) {
            HStack(spacing: 8) {
                Image(systemName: channelIcon)
                    .font(.system(size: 16))
                    .foregroundColor(isSelected ? ThemeManager.textPrimary : ThemeManager.textMuted)
                
                Text(channel.name)
                    .font(.system(size: 15, weight: isSelected ? .semibold : .medium))
                    .foregroundColor(isSelected ? ThemeManager.textPrimary : ThemeManager.textSecondary)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? ThemeManager.hoverColor : Color.clear)
            .cornerRadius(4)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 8)
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

struct UserPanelView: View {
    @EnvironmentObject var appState: AppState
    @State private var isMuted = false
    @State private var isDeafened = false
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(ThemeManager.borderColor)
            
            HStack(spacing: 12) {
                // Avatar
                Circle()
                    .fill(ThemeManager.accent)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Text(appState.user?.username.prefix(1).uppercased() ?? "U")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    )
                
                // User info
                VStack(alignment: .leading, spacing: 2) {
                    Text(appState.user?.username ?? "User")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    HStack(spacing: 4) {
                        Circle()
                            .fill(ThemeManager.success)
                            .frame(width: 8, height: 8)
                        
                        Text("Online")
                            .font(.system(size: 12))
                            .foregroundColor(ThemeManager.textSecondary)
                    }
                }
                
                Spacer()
                
                // Controls
                HStack(spacing: 8) {
                    Button(action: { isMuted.toggle() }) {
                        Image(systemName: isMuted ? "mic.slash.fill" : "mic.fill")
                            .font(.system(size: 16))
                            .foregroundColor(isMuted ? ThemeManager.danger : ThemeManager.textSecondary)
                    }
                    
                    Button(action: { isDeafened.toggle() }) {
                        Image(systemName: isDeafened ? "speaker.slash.fill" : "speaker.wave.2.fill")
                            .font(.system(size: 16))
                            .foregroundColor(isDeafened ? ThemeManager.danger : ThemeManager.textSecondary)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 16))
                            .foregroundColor(ThemeManager.textSecondary)
                    }
                }
            }
            .padding(12)
            .background(ThemeManager.backgroundTertiary)
        }
    }
}

#Preview {
    ChannelSidebarView(viewModel: ServerViewModel())
        .environmentObject(AppState())
        .frame(width: 280)
}
