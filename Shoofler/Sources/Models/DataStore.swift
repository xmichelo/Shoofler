import ComposableArchitecture

class DataStore {
    static let shared = Store(
        initialState: ShooflerFeature.State()
    ) {
        ShooflerFeature()
    }
}
