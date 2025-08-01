import ComposableArchitecture

@Reducer
struct SystemMonitorFeature {
    @ObservableState
    struct State: Equatable {
        var isMonitoring: Bool = false
        var appHasAccessibilityPermissions: Bool = false
        
        init() {
            self.isMonitoring = false
            self.appHasAccessibilityPermissions = Shoofler.appHasAccessibilityPermissions()
        }
    }

    enum Action {
        case startMonitoring
        case stopMonitoring
        case timerTick
        case accessibilityPermissionsChanged(_ hasPermissions: Bool)
    }
    
    @Dependency(\.continuousClock) var clock
    
    private enum CancelID {
        case monitoring
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startMonitoring:
                if state.isMonitoring {
                    logWarn("System monitoring was requested to start but it was already running.")
                    return .none
                }
                logInfo("Started system monitoring.")
                state.isMonitoring = true
                let hasPermissions = state.appHasAccessibilityPermissions
                return .run { send in
                    await send(.accessibilityPermissionsChanged(hasPermissions))
                    for await _ in clock.timer(interval: .seconds(1)) {
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.monitoring)
                
            case .stopMonitoring:
                if !state.isMonitoring {
                    logWarn("System monitoring was requested to stop but it was not running.")
                    return .none
                }
                state.isMonitoring = false
                logInfo("Stopped system monitoring.")
                return .cancel(id: CancelID.monitoring)
                
            case .timerTick:
                let hasPermissions = Shoofler.appHasAccessibilityPermissions()
                if state.appHasAccessibilityPermissions == hasPermissions {
                    return .none
                }
                state.appHasAccessibilityPermissions = hasPermissions
                return .send(.accessibilityPermissionsChanged(hasPermissions))
                
            case .accessibilityPermissionsChanged:
                return .none // Handled by the parent.
            }
        }
    }
}

