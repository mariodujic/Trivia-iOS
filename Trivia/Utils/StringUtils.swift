import Foundation

extension StringProtocol {
    
    var htmlToAttributedString: NSAttributedString? {
        Data(utf8).dataHtmlToAttributedString
    }
    
    var htmlToString: String {
        htmlToAttributedString?.string ?? ""
    }
}
