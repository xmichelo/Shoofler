import SwiftUI

struct ReadOnlyTextField: View {
    let label: String
    let text: String
    var expand: Bool = true
    let cornerRadius: CGFloat = 4.0
    let borderOpacity: Double = 0.4
    
    var body: some View {
        LabeledContent(label) {
            HStack {
                Text(text)
                    .padding(4)
                    
                if expand {
                    Spacer()
                }
            }
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.secondary.opacity(borderOpacity)))
        }
    }
}

struct SnippetDetailsView: View {
    var snippet: Snippet?
    
    var body: some View {
        ScrollView {
            VStack {
                if let snippet = snippet {
                    Form {
                        ReadOnlyTextField(label: "Trigger", text: snippet.trigger)
                        ReadOnlyTextField(label: "Description", text: snippet.description ?? "")
                        ReadOnlyTextField(label: "Content", text: snippet.content)
                    }
                    Spacer()
                } else {
                    EmptyView()
                }
            }
            .padding()
        }

    }
}

#Preview {
    SnippetDetailsView(snippet: SnippetList.sample.first)
}

