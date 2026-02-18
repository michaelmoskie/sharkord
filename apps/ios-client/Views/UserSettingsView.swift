import SwiftUI

struct UserSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                ThemeManager.backgroundTertiary
                    .ignoresSafeArea()
                
                HStack(spacing: 0) {
                    // Sidebar
                    SettingsSidebarView(selectedTab: $selectedTab)
                        .frame(width: 200)
                    
                    Divider()
                        .background(ThemeManager.borderColor)
                    
                    // Content
                    Group {
                        switch selectedTab {
                        case 0:
                            AccountSettingsView()
                        case 1:
                            ProfileSettingsView()
                        case 2:
                            PrivacySettingsView()
                        case 3:
                            AppearanceSettingsView()
                        case 4:
                            VoiceSettingsView()
                        case 5:
                            NotificationSettingsView()
                        default:
                            AccountSettingsView()
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Settings")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(ThemeManager.textPrimary)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(ThemeManager.textMuted)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct SettingsSidebarView: View {
    @Binding var selectedTab: Int
    
    let sections: [(String, [(Int, String, String)])] = [
        ("User Settings", [
            (0, "My Account", "person.fill"),
            (1, "Profile", "person.crop.circle"),
            (2, "Privacy & Safety", "lock.fill"),
            (3, "Appearance", "paintbrush.fill")
        ]),
        ("App Settings", [
            (4, "Voice & Video", "mic.fill"),
            (5, "Notifications", "bell.fill")
        ])
    ]
    
    var body: some View {
        ZStack {
            ThemeManager.backgroundSecondary
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(sections, id: \.0) { section in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(section.0)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(ThemeManager.textMuted)
                                .textCase(.uppercase)
                                .padding(.horizontal, 16)
                                .padding(.top, 8)
                            
                            ForEach(section.1, id: \.0) { item in
                                Button(action: { selectedTab = item.0 }) {
                                    HStack(spacing: 12) {
                                        Image(systemName: item.2)
                                            .font(.system(size: 14))
                                            .foregroundColor(selectedTab == item.0 ? ThemeManager.textPrimary : ThemeManager.textMuted)
                                        
                                        Text(item.1)
                                            .font(.system(size: 15, weight: selectedTab == item.0 ? .semibold : .medium))
                                            .foregroundColor(selectedTab == item.0 ? ThemeManager.textPrimary : ThemeManager.textSecondary)
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(selectedTab == item.0 ? ThemeManager.hoverColor : Color.clear)
                                    .cornerRadius(6)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.horizontal, 8)
                            }
                        }
                    }
                }
                .padding(.vertical, 16)
            }
        }
    }
}

struct AccountSettingsView: View {
    var body: some View {
        SettingsContentWrapper(title: "My Account") {
            SettingItem(label: "Username", value: "testuser")
            SettingItem(label: "Email", value: "user@example.com")
            
            Divider()
                .background(ThemeManager.borderColor)
                .padding(.vertical, 8)
            
            Button(action: {}) {
                Text("Change Password")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ThemeManager.accent)
                    .cornerRadius(8)
            }
            
            Button(action: {}) {
                Text("Log Out")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ThemeManager.danger)
                    .cornerRadius(8)
            }
        }
    }
}

struct ProfileSettingsView: View {
    @State private var displayName = "User"
    @State private var bio = ""
    
    var body: some View {
        SettingsContentWrapper(title: "Profile") {
            VStack(alignment: .leading, spacing: 8) {
                Text("Display Name")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(ThemeManager.textSecondary)
                
                TextField("", text: $displayName)
                    .padding()
                    .background(ThemeManager.backgroundSecondary)
                    .foregroundColor(ThemeManager.textPrimary)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("About Me")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(ThemeManager.textSecondary)
                
                TextEditor(text: $bio)
                    .frame(height: 100)
                    .padding(8)
                    .background(ThemeManager.backgroundSecondary)
                    .foregroundColor(ThemeManager.textPrimary)
                    .cornerRadius(8)
            }
            
            Button(action: {}) {
                Text("Save Changes")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ThemeManager.accent)
                    .cornerRadius(8)
            }
        }
    }
}

struct PrivacySettingsView: View {
    @State private var allowDMs = true
    @State private var showOnlineStatus = true
    
    var body: some View {
        SettingsContentWrapper(title: "Privacy & Safety") {
            ToggleSettingItem(label: "Allow Direct Messages", isOn: $allowDMs)
            ToggleSettingItem(label: "Show Online Status", isOn: $showOnlineStatus)
        }
    }
}

struct AppearanceSettingsView: View {
    @State private var darkMode = true
    @State private var compactMode = false
    
    var body: some View {
        SettingsContentWrapper(title: "Appearance") {
            ToggleSettingItem(label: "Dark Mode", isOn: $darkMode)
            ToggleSettingItem(label: "Compact Mode", isOn: $compactMode)
            
            Text("Sharkord iOS uses a dark theme by default for the best experience.")
                .font(.system(size: 13))
                .foregroundColor(ThemeManager.textMuted)
                .padding(.top, 8)
        }
    }
}

struct VoiceSettingsView: View {
    @State private var echoCancellation = true
    @State private var noiseSuppression = true
    
    var body: some View {
        SettingsContentWrapper(title: "Voice & Video") {
            ToggleSettingItem(label: "Echo Cancellation", isOn: $echoCancellation)
            ToggleSettingItem(label: "Noise Suppression", isOn: $noiseSuppression)
        }
    }
}

struct NotificationSettingsView: View {
    @State private var enableNotifications = true
    @State private var messageNotifications = true
    
    var body: some View {
        SettingsContentWrapper(title: "Notifications") {
            ToggleSettingItem(label: "Enable Notifications", isOn: $enableNotifications)
            ToggleSettingItem(label: "Message Notifications", isOn: $messageNotifications)
        }
    }
}

struct SettingsContentWrapper<Content: View>: View {
    let title: String
    let content: () -> Content
    
    var body: some View {
        ZStack {
            ThemeManager.background
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(title)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    content()
                }
                .padding(24)
            }
        }
    }
}

struct SettingItem: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(ThemeManager.textSecondary)
            
            Text(value)
                .font(.system(size: 15))
                .foregroundColor(ThemeManager.textPrimary)
        }
    }
}

struct ToggleSettingItem: View {
    let label: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(ThemeManager.textPrimary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(ThemeManager.accent)
        }
        .padding()
        .background(ThemeManager.backgroundSecondary)
        .cornerRadius(8)
    }
}

#Preview {
    UserSettingsView()
}
