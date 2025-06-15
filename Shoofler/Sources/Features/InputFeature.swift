import Foundation
import Carbon
import AppKit
import ComposableArchitecture

/// The input feature is in charge of keyboard monitoring and event processing.
@Reducer
struct InputFeature {
    /// Resetters are key that will cause the  accumulator to be reset.
    static let resetters = [
        kVK_Escape,
        kVK_Space,
        kVK_Return,
        kVK_Tab,
        kVK_UpArrow,
        kVK_DownArrow,
        kVK_LeftArrow,
        kVK_RightArrow,
        kVK_Home,
        kVK_End,
        kVK_PageUp,
        kVK_PageDown,
        kVK_ForwardDelete,
    ]
    
    @ObservableState
    struct State: Equatable {
        var accumulator: String = ""
    }
    
    enum Action {
        case installKeyboardMonitor(StoreOf<InputFeature>)
        case keyPressed(KeyEvent)
        case accumulatorChanged(String)
        case resetAccumulator
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
                return processKey(state: &state, event: event)
                
            case .accumulatorChanged(_):
                return .none
                
            case .resetAccumulator:
                if !state.accumulator.isEmpty {
                    state.accumulator = ""
                    return .send(.accumulatorChanged(""));
                }
                return .none
            }
        }
    }
    
    /// Process a key event.
    ///
    /// - Parameters:
    ///     - state: the state of the feature.
    ///     - event: the event.
    ///
    /// - Returns: the effect resulting from the processing.
    func processKey(state: inout State, event: KeyEvent) -> Effect<InputFeature.Action> {
        if event.modifierFlags.contains(.command) {
            return .send(.resetAccumulator)
        }
        
        if InputFeature.resetters.contains(event.keyCode) {
            return .send(.resetAccumulator)
        }
        
        if event.keyCode == kVK_Delete {
            if (!state.accumulator.isEmpty) {
                state.accumulator.removeLast()
                return .send(.accumulatorChanged(state.accumulator))
            }
            return .none
        }

        guard let chars = event.characters else { return .none }
        if !chars.isEmpty {
            state.accumulator.append(chars);
            return .send(.accumulatorChanged(state.accumulator));
        }
        
        return .none
    }
}
