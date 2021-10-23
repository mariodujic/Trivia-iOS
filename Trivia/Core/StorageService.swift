import Foundation

final class StorageService {
    
    func setBool(key: String, value: Bool) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getBool(key: String) -> Bool {
        UserDefaults.standard.bool(forKey: key)
    }
}
