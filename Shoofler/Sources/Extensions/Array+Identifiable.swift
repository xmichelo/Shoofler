import Foundation

extension Array where Element: Identifiable {
    /// Appends or replaces a element of the array
    ///
    /// - parameters:
    ///     - group: The element to add or replace.
    mutating func appendReplace(_ element: Element) {
        guard let index = self.firstIndex(where: { $0.id == element.id } ) else { return self.append(element) }
        self[index] = element
    }
    
    /// Test whether the array contains an element with the given ID.
    ///
    /// - parameters:
    ///     - id: The snippet ID.
    ///
    /// - returns:
    ///     - true if and only if the list contains the element with the given ID.
    public func contains(id: Element.ID) -> Bool {
        return self.contains { $0.id == id }
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

    /// Subscript based on ID
    ///
    /// - Parameters:
    ///     - id The ID of the element.
    ///
    /// - Returns: The first element in the list with the given ID.
    subscript (id: Element.ID) -> Element? {
        get {
            return self.first(where: { $0.id == id })
        }
        
        set {
            if let newValue = newValue {
                self.appendReplace(newValue)
            }
        }
    }
}
