import SwiftUI
import ComposableArchitecture

struct SnippetItemView: View {
    let snippet: Snippet
    
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                HStack {
                    Text(snippet.description ?? snippet.trigger)
                        .lineLimit(1)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(snippet.trigger)
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.accent)
                        .clipShape(Capsule())
                }
                HStack {
                    Text(snippet.content)
                        .lineLimit(1)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .padding(3)
        }
    }
}

#Preview {
    SnippetItemView(snippet: SnippetList.sample.last!)
        .frame(minWidth: 200)
        .padding()
}
