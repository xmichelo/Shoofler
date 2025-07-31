import AppKit

/// A sendable wrapper for key related events.
struct KeyEvent: Sendable {
    var characters: String?
    var keyCode: Int
    var modifierFlags: NSEvent.ModifierFlags
    
    static func from(nsEvent: NSEvent) -> Self {
        return Self(
            characters: nsEvent.characters,
            keyCode: Int(nsEvent.keyCode),
            modifierFlags: nsEvent.modifierFlags
        )
    }
}
