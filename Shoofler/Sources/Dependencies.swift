import Dependencies
import ComposableArchitecture

private enum StoreKey: DependencyKey {
    static var liveValue: StoreOf<AppFeature> {
        MainActor.assumeIsolated {
            Store(initialState: AppFeature.State()) {
                AppFeature()
            }
        }
    }
}

extension DependencyValues {
    var appStore: StoreOf<AppFeature> {
        get { self[StoreKey.self] }
        set { self[StoreKey.self] = newValue }
    }
}
