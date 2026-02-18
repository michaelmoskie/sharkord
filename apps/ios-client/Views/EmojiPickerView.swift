import SwiftUI

struct EmojiPickerView: View {
    let onSelect: (String) -> Void
    @Environment(\.dismiss) var dismiss
    
    let emojis = [
        "😀", "😃", "😄", "😁", "😆", "😅", "🤣", "😂", "🙂", "🙃",
        "😉", "😊", "😇", "🥰", "😍", "🤩", "😘", "😗", "😚", "😙",
        "😋", "😛", "😜", "🤪", "😝", "🤑", "🤗", "🤭", "🤫", "🤔",
        "🤐", "🤨", "😐", "😑", "😶", "😏", "😒", "🙄", "😬", "🤥",
        "😌", "😔", "😪", "🤤", "😴", "😷", "🤒", "🤕", "🤢", "🤮",
        "👍", "👎", "👌", "✌️", "🤞", "🤟", "🤘", "🤙", "👈", "👉",
        "🔥", "⭐", "✨", "💯", "💪", "🙏", "❤️", "💙", "💚", "💛"
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 44))
                ], spacing: 12) {
                    ForEach(emojis, id: \.self) { emoji in
                        Button(action: {
                            onSelect(emoji)
                            dismiss()
                        }) {
                            Text(emoji)
                                .font(.system(size: 32))
                        }
                        .frame(width: 44, height: 44)
                    }
                }
                .padding()
            }
            .background(ThemeManager.background)
            .navigationTitle("Choose Emoji")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(ThemeManager.accent)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    EmojiPickerView { emoji in
        print("Selected: \(emoji)")
    }
}
