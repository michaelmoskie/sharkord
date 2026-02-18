import Foundation

enum AppScreen {
    case loading
    case connect
    case serverView
    case disconnected
}

class AppState: ObservableObject {
    @Published var currentScreen: AppScreen = .connect
    @Published var isConnected: Bool = false
    @Published var currentServer: Server?
    @Published var currentChannel: Channel?
    @Published var user: User?
    @Published var token: String?
    
    func connect(serverUrl: String, token: String) {
        self.token = token
        // Connection logic will be handled by TRPCClient
        currentScreen = .serverView
        isConnected = true
    }
    
    func disconnect() {
        isConnected = false
        currentScreen = .disconnected
        currentServer = nil
        currentChannel = nil
    }
}
