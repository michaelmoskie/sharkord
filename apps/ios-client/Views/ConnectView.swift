import SwiftUI

struct ConnectView: View {
    @EnvironmentObject var appState: AppState
    @State private var serverUrl: String = "ws://localhost:4991"
    @State private var token: String = ""
    @State private var isConnecting: Bool = false
    
    var body: some View {
        ZStack {
            ThemeManager.backgroundTertiary
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                // Logo and title
                VStack(spacing: 16) {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .font(.system(size: 80))
                        .foregroundColor(ThemeManager.accent)
                    
                    Text("Sharkord")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Text("Connect to your server")
                        .font(.system(size: 18))
                        .foregroundColor(ThemeManager.textSecondary)
                }
                .padding(.top, 60)
                
                // Input fields
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Server URL")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(ThemeManager.textSecondary)
                        
                        TextField("", text: $serverUrl)
                            .placeholder(when: serverUrl.isEmpty) {
                                Text("ws://localhost:4991")
                                    .foregroundColor(ThemeManager.textMuted)
                            }
                            .padding()
                            .background(ThemeManager.backgroundSecondary)
                            .foregroundColor(ThemeManager.textPrimary)
                            .cornerRadius(8)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Access Token")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(ThemeManager.textSecondary)
                        
                        SecureField("", text: $token)
                            .placeholder(when: token.isEmpty) {
                                Text("Enter your access token")
                                    .foregroundColor(ThemeManager.textMuted)
                            }
                            .padding()
                            .background(ThemeManager.backgroundSecondary)
                            .foregroundColor(ThemeManager.textPrimary)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 32)
                
                // Connect button
                Button(action: handleConnect) {
                    HStack {
                        if isConnecting {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Connect")
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ThemeManager.accent)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 32)
                .disabled(serverUrl.isEmpty || token.isEmpty || isConnecting)
                .opacity((serverUrl.isEmpty || token.isEmpty || isConnecting) ? 0.5 : 1.0)
                
                Spacer()
            }
        }
    }
    
    private func handleConnect() {
        isConnecting = true
        // Simulate connection delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            appState.connect(serverUrl: serverUrl, token: token)
            isConnecting = false
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    ConnectView()
        .environmentObject(AppState())
        .environmentObject(ThemeManager())
}
