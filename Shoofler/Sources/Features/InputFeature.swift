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
        var monitorHandle: Any? = nil
        
        static func ==(lhs: Self, rhs: Self) -> Bool {
            return lhs.accumulator == rhs.accumulator
        }
    }
    
    enum Action {
        case addEventMonitor
        case removeEventMonitor
        case keyPressed(KeyEvent)
        case accumulatorChanged(String)
        case resetAccumulator
        case setMonitorHandle(Any?)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addEventMonitor:
                if let handle = state.monitorHandle {
                    NSEvent.removeMonitor(handle)
                    logInfo("The existing event monitor was successfully added.")
                }
                return .run { send in
                    // The event handler will outlive the run closure.
                    // TCA states that we should not use the closure's `send`
                    // parameter in this case, so the store is a parameter of the action.
                    let handle = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
                        let keyEvent = KeyEvent.from(nsEvent: event)
                        Task { @MainActor in
                            @Dependency(\.appStore) var appStore
                            appStore.send(.engine(.input(.keyPressed(keyEvent))))
                        }
                    }
                    if handle == nil {
                        logError("Failed to add event monitor.");
                    } else {
                        logInfo("Event monitor was successfully added.");
                    }
                    await send(.setMonitorHandle(handle))
                }
                
            case .removeEventMonitor:
                if let handle = state.monitorHandle {
                    NSEvent.removeMonitor(handle)
                    logInfo("Event monitor was successfully removed.")
                } else {
                    logInfo("Event monitor is not installed.")
                }
                return .none
                
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
                
            case .setMonitorHandle(let handle):
                state.monitorHandle = handle
                return .none
            }
        }
    }
    
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
