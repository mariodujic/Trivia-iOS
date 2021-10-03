import Foundation

extension StringProtocol {
    
    var htmlToAttributedString: NSAttributedString? {
        Data(utf8).dataHtmlToAttributedString
    }
    
    var htmlToString: String {
        htmlToAttributedString?.string ?? ""
    }
    
    var isDigits: Bool {
        guard !self.isEmpty else { return false }
        return !self.contains { Int(String($0)) == nil }
    }
}
