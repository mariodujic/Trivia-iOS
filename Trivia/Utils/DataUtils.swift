import Foundation

extension Data {
    var dataHtmlToAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return  nil
        }
    }
    var dataHtmlToString: String { dataHtmlToAttributedString?.string ?? "" }
}
