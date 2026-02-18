import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            ThemeManager.backgroundTertiary
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .font(.system(size: 60))
                    .foregroundColor(ThemeManager.accent)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isAnimating)
                
                Text("Loading Sharkord...")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(ThemeManager.textSecondary)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: ThemeManager.accent))
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    LoadingView()
}
