import SwiftUI

struct UserProfileView: View {
    let user: User
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                ThemeManager.backgroundTertiary
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Banner and avatar
                        ZStack(alignment: .bottom) {
                            // Banner
                            Rectangle()
                                .fill(avatarColor)
                                .frame(height: 120)
                            
                            // Avatar
                            Circle()
                                .fill(avatarColor)
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Text(user.username.prefix(1).uppercased())
                                        .font(.system(size: 32, weight: .semibold))
                                        .foregroundColor(.white)
                                )
                                .overlay(
                                    Circle()
                                        .stroke(ThemeManager.backgroundTertiary, lineWidth: 6)
                                )
                                .offset(y: 40)
                        }
                        
                        // User info
                        VStack(spacing: 16) {
                            VStack(spacing: 4) {
                                Text(user.displayName ?? user.username)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(ThemeManager.textPrimary)
                                
                                Text("@\(user.username)")
                                    .font(.system(size: 16))
                                    .foregroundColor(ThemeManager.textSecondary)
                            }
                            .padding(.top, 32)
                            
                            // Status
                            HStack(spacing: 8) {
                                Circle()
                                    .fill(statusColor)
                                    .frame(width: 12, height: 12)
                                
                                Text(user.status.rawValue.capitalized)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(ThemeManager.textPrimary)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(ThemeManager.backgroundSecondary)
                            .cornerRadius(16)
                        }
                        
                        // Profile sections
                        VStack(spacing: 16) {
                            ProfileSection(title: "About Me") {
                                Text("No information provided")
                                    .font(.system(size: 14))
                                    .foregroundColor(ThemeManager.textSecondary)
                            }
                            
                            ProfileSection(title: "Member Since") {
                                Text(formatDate(user.createdAt))
                                    .font(.system(size: 14))
                                    .foregroundColor(ThemeManager.textPrimary)
                            }
                            
                            // Action buttons
                            VStack(spacing: 12) {
                                Button(action: {}) {
                                    HStack {
                                        Image(systemName: "message.fill")
                                        Text("Send Message")
                                            .font(.system(size: 15, weight: .medium))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(ThemeManager.accent)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                                
                                Button(action: {}) {
                                    HStack {
                                        Image(systemName: "phone.fill")
                                        Text("Start Voice Call")
                                            .font(.system(size: 15, weight: .medium))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(ThemeManager.success)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(ThemeManager.accent)
                }
            }
        }
        .preferredColorScheme(.dark)
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
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct ProfileSection<Content: View>: View {
    let title: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(ThemeManager.textMuted)
                .textCase(.uppercase)
            
            content()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(ThemeManager.backgroundSecondary)
                .cornerRadius(8)
        }
    }
}

#Preview {
    UserProfileView(user: User(id: "1", username: "testuser", displayName: "Test User", avatar: nil, email: nil, isOnline: true, status: .online, createdAt: Date()))
}
