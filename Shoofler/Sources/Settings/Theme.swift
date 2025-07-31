import SwiftUI

/// Enumeration for the application theme.
enum Theme: String, CaseIterable, Identifiable {
    /// The theme defined by the user at the system level.
    case system = "System"
    
    /// The dark theme.
    case dark = "Dark"
    
    /// The light theme.
    case light = "Light"
    
    /// The identifier for the theme
    var id: String { self.rawValue }
    
    /// The ColorScheme corresponding to the theme.
    var colorScheme: ColorScheme? {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
}
