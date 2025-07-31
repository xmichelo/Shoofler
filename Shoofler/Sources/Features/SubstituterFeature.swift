import ComposableArchitecture
import AppKit

@Reducer
struct SubstituterFeature {
    @ObservableState
    struct State: Equatable {
        @Shared(.snippets) var snippets: SnippetList = []
    }
    
    enum Action {
        case performSubstitution(Substitution)
        case substitutionWasPerformed
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .performSubstitution(let substitution):
                
                let pasteboard = NSPasteboard.general
                let pasteboardContent = pasteboard.string(forType: .string)
                let str = replaceVariablesIn(
                    snippet: substitution.snippet,
                    pasteboardContent: pasteboardContent,
                    snippetList: state.snippets)
                pasteboard.clearContents()
                pasteboard.setString(str, forType: .string)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    let eventSource = CGEventSource(stateID: .hidSystemState)
                    emulateDeleteKey(repeatCount: substitution.eraseCount, eventSource: eventSource)
                    emulatePaste(eventSource: eventSource);
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        if let pasteboardContent {
                            pasteboard.setString(pasteboardContent, forType: .string)
                        } else {
                            pasteboard.clearContents()
                        }
                    }
                }
                return .send(.substitutionWasPerformed)
                
            case .substitutionWasPerformed:
                return .none
            }
        }
    }
    
    func emulateDeleteKey(repeatCount: Int = 1, eventSource: CGEventSource?) {
        let backspaceDown = CGEvent(keyboardEventSource: eventSource, virtualKey: 0x33, keyDown: true)
        let backspaceUp = CGEvent(keyboardEventSource: eventSource, virtualKey: 0x33, keyDown: false)

        for _ in 0..<repeatCount {
            backspaceDown?.post(tap: .cghidEventTap)
            backspaceUp?.post(tap: .cghidEventTap)
        }
    }
    
    func emulatePaste(eventSource: CGEventSource?) {
        let keyDown = CGEvent(keyboardEventSource: eventSource, virtualKey: 0x09, keyDown: true)
        keyDown?.flags = .maskCommand
        let keyUp = CGEvent(keyboardEventSource: eventSource, virtualKey: 0x09, keyDown: false)
        keyUp?.flags = .maskCommand

        keyDown?.post(tap: .cghidEventTap)
        keyUp?.post(tap: .cghidEventTap)
    }
    
}

/// Evaluate a snippet by performing substitution of variables.
func replaceVariablesIn(snippet: String, pasteboardContent: String?, snippetList: SnippetList) -> String {
    return snippet.replacingOccurrences(of: "#{clipboard}", with: pasteboardContent ?? "")
}
