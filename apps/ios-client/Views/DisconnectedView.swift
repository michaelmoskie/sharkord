import SwiftUI

struct DisconnectedView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            ThemeManager.backgroundTertiary
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Image(systemName: "wifi.slash")
                    .font(.system(size: 60))
                    .foregroundColor(ThemeManager.danger)
                
                Text("Disconnected")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(ThemeManager.textPrimary)
                
                Text("Lost connection to the server")
                    .font(.system(size: 16))
                    .foregroundColor(ThemeManager.textSecondary)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    appState.currentScreen = .connect
                }) {
                    Text("Reconnect")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: 200)
                        .padding()
                        .background(ThemeManager.accent)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
            }
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    DisconnectedView()
        .environmentObject(AppState())
}
