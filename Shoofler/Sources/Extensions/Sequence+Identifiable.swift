import Foundation

extension Sequence where Element: Identifiable {
    /// Test whether the list contains a snippets with the given ID.
    ///
    /// - parameters:
    ///     - id: The snippet ID.
    ///
    /// - returns:
    ///     - true if and only if the list contains the element with the given ID.
    public func contains(id: Element.ID) -> Bool {
        return self.contains { $0.id == id }
    }
    
    /// Subscript based on ID
    ///
    /// - Parameters:
    ///     - id The ID of the element.
    ///
    /// - Returns: The first snippet in the list with the given ID.
    subscript (id: Element.ID) -> Element? {
        return self.first(where: { $0.id == id })
    }
    
    /// Return a sanitized version of the array by removing duplicate IDs.
    ///
    /// Only the first element with a given ID  is kept.
    ///
    /// - Returns: The sanitized list.
    func sanitized() -> [Element] {
        var ids: Set<Element.ID> = []
        return self.filter { element in
            if ids.contains(element.id) {
                return false
            }
            ids.insert(element.id)
            return true
        }
    }
}


