import ComposableArchitecture
import AppKit

@Reducer
struct SubstituterFeature {
    @ObservableState
    struct State: Equatable {}
    
    enum Action {
        case performSubstitution(Substitution)
        case substitutionWasPerformed
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .performSubstitution(let substitution):
                let pasteboard = NSPasteboard.general
                pasteboard.clearContents()
                pasteboard.setString(substitution.newText, forType: .string)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    let eventSource = CGEventSource(stateID: .hidSystemState)
                    emulateDeleteKey(repeatCount: substitution.eraseCount, eventSource: eventSource)
                    emulatePaste(eventSource: eventSource);
                }
                return .send(.substitutionWasPerformed)
                
            case .substitutionWasPerformed:
                return .none
            }
        }
    }
    
    /// Synthesize pressing of the delete key.
    ///
    /// - Parameters:
    ///     - repeatCount: the number of time to repeat the key press.
    ///     - eventSource: the event source. Can be created using `CGEventSource(stateID:)`.
    func emulateDeleteKey(repeatCount: Int = 1, eventSource: CGEventSource?) {
        let backspaceDown = CGEvent(keyboardEventSource: eventSource, virtualKey: 0x33, keyDown: true)
        let backspaceUp = CGEvent(keyboardEventSource: eventSource, virtualKey: 0x33, keyDown: false)

        for _ in 0..<repeatCount {
            backspaceDown?.post(tap: .cghidEventTap)
            backspaceUp?.post(tap: .cghidEventTap)
        }
    }
    
    /// Synthesize a paste event (Cmd+V).
    ///
    /// - Parameters:
    ///     - eventSource: the event source. Can be created using `CGEventSource(stateID:)`.
    func emulatePaste(eventSource: CGEventSource?) {
        let keyDown = CGEvent(keyboardEventSource: eventSource, virtualKey: 0x09, keyDown: true)
        keyDown?.flags = .maskCommand
        let keyUp = CGEvent(keyboardEventSource: eventSource, virtualKey: 0x09, keyDown: false)
        keyUp?.flags = .maskCommand

        keyDown?.post(tap: .cghidEventTap)
        keyUp?.post(tap: .cghidEventTap)
    }
}
