import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            switch appState.currentScreen {
            case .loading:
                LoadingView()
            case .connect:
                ConnectView()
            case .serverView:
                ServerView()
            case .disconnected:
                DisconnectedView()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
        .environmentObject(ThemeManager())
}
