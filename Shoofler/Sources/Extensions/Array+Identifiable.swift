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
}
