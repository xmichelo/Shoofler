import SwiftUI
import ComposableArchitecture

struct SnippetItemView: View {
    let snippet: Snippet
    let selected: Bool
    
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
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(selected ? Color.accentColor: .clear)
                .opacity(selected ? 0.5: 0)
        )
    }
}

struct DraggableSnippetItemView: View {
    let snippet: Snippet
    let selected: Bool
    
    var body: some View {
        SnippetItemView(snippet: snippet, selected: selected)
            .draggable(snippet) {
                SnippetItemView(snippet: snippet, selected: false).opacity(0.8)
            }
            .onDrag {
                return NSItemProvider(object: snippet.trigger as NSString)
            }
    }
}

#Preview {
    DraggableSnippetItemView(snippet: SnippetList.sample.last!, selected: false)
        .frame(minWidth: 200)
        .padding()
}
