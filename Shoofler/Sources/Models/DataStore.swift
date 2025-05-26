import ComposableArchitecture

class DataStore {
    static let shared = Store(
        initialState: AppFeature.State()
    ) {
        AppFeature()
    }
}
