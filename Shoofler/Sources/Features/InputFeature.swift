import Foundation
import Carbon
import AppKit
import ComposableArchitecture

struct KeyEvent: Sendable {
    
    var characters: String?

    static func from(nsEvent: NSEvent) -> Self {
        return Self(characters: nsEvent.characters)
    }
}

@Reducer
struct InputFeature {
    @ObservableState
    struct State: Equatable {
        var acummulator: String = ""
    }
    
    enum Action {
        case installKeyboardMonitor(StoreOf<InputFeature>)
        case keyPressed(KeyEvent)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .installKeyboardMonitor(let store):
                return .run { _ in
                    // The event handler will outlive the run closure.
                    // TCA states that we should not use the closure's `send`
                    // parameter in this case, so the store is a parameter of the action.
                    NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
                        let keyEvent = KeyEvent.from(nsEvent: event)
                        Task {
                            await store.send(.keyPressed(keyEvent))
                        }
                    }
                }
            case .keyPressed(let event):
                if let chars = event.characters {
                    if !chars.isEmpty {
                        print(chars)
                    }
                }
                return .none;
            }
        }
    }
}

// func installKeyboardMonitor(state) {
//        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
//
//            //print(event)
//            let resetters = [
//                kVK_Escape,
//                kVK_Space,
//                kVK_Return,
//                kVK_Tab,
//                kVK_UpArrow,
//                kVK_DownArrow,
//                kVK_LeftArrow,
//                kVK_RightArrow,
//                kVK_Home,
//                kVK_End,
//                kVK_PageUp,
//                kVK_PageDown,
//                kVK_ForwardDelete,
//            ]
//
//            let intCode = Int(event.keyCode)
//
//            if resetters.contains(intCode) {
//                print("Resetting accumulator")
////                accum = ""
//                return
//            }
//
//            if intCode == kVK_Delete {
//                if (!accum.isEmpty) {
//                    accum.removeLast()
//                }
//                print("Delete. Accum is now \(accum)")
//                return
//            }
//
//            if let chars = event.characters {
//                if !chars.isEmpty {
//                    accum += chars
//                }
//            }
//
//            if accum == "lorem" {
//                print("I should print lorem")
//                let pasteboard = NSPasteboard.general
//                pasteboard.clearContents()
//                pasteboard.setString("lorem ipsum", forType: .string)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    let source = CGEventSource(stateID: .hidSystemState)
//                    let backspaceDown = CGEvent(keyboardEventSource: source, virtualKey: 0x33, keyDown: true)
//                    let backspaceUp = CGEvent(keyboardEventSource: source, virtualKey: 0x33, keyDown: false)
//                    let keyDown = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: true)
//                    let keyUp = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: false)
//
//                    keyDown?.flags = .maskCommand
//                    keyUp?.flags = .maskCommand
//                    for _ in 0..<accum.count {
//                        backspaceDown?.post(tap: .cghidEventTap)
//                        backspaceUp?.post(tap: .cghidEventTap)
//                    }
//                    keyDown?.post(tap: .cghidEventTap)
//                    keyUp?.post(tap: .cghidEventTap)
//                }
//            }
