
import Foundation



class UserManager {
        
    public static let instance = UserManager()
    private init() {}
    
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: "userName")
    }
    
 
    func setUserName(userName: String) {
        UserDefaults.standard.set(userName, forKey: "userName")
    }
    
}
