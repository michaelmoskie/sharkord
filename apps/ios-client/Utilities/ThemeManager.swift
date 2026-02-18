import SwiftUI

class ThemeManager: ObservableObject {
    // Dark theme colors matching Discord-like aesthetics
    static let background = Color(hex: "#36393f")
    static let backgroundSecondary = Color(hex: "#2f3136")
    static let backgroundTertiary = Color(hex: "#202225")
    static let channelBackground = Color(hex: "#40444b")
    
    static let textPrimary = Color(hex: "#dcddde")
    static let textSecondary = Color(hex: "#b9bbbe")
    static let textMuted = Color(hex: "#72767d")
    
    static let accent = Color(hex: "#5865f2")
    static let accentHover = Color(hex: "#4752c4")
    static let success = Color(hex: "#3ba55d")
    static let danger = Color(hex: "#ed4245")
    static let warning = Color(hex: "#faa81a")
    
    static let borderColor = Color(hex: "#202225")
    static let hoverColor = Color(hex: "#34373c")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
