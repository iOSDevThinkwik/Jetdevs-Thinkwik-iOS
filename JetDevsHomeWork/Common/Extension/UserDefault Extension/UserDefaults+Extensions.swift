//
//  UserDefaults+Extensions.swift
//  JetDevsHomeWork
//
//  Created by Hemang Solanki on 14/12/22.
//

import Foundation

enum UserDefaultsKey: String {
    
    case userInfo = "userInfo"
    case XAcc = "accessToken"
    
}

extension UserDefaults {
    
    func setUserInfo(user: User) {
        do {
            let encodedUserInfo = try PropertyListEncoder().encode(user)
            self.set(encodedUserInfo, forKey: UserDefaultsKey.userInfo.rawValue)
            self.set(encodedUserInfo, forKey: "isUserDetail")
            self.synchronize()
        } catch {
            print("Userinfo not saved..")
        }
    }
    
    func getUserInfo() -> User? {
        if let data = UserDefaults.standard.value(forKey: UserDefaultsKey.userInfo.rawValue) as? Data {
            let user = try? PropertyListDecoder().decode(User.self, from: data)
            return user
        }
        return nil
    }
    
    var accessToken: String {
        set{
            self.setValue(newValue, forKey: UserDefaultsKey.XAcc.rawValue)
            self.synchronize()
        }
        get {
            return (self.value(forKey: UserDefaultsKey.XAcc.rawValue) as? String) ?? ""
        }
    }
    
    func isUserLoggedIn() -> Bool {
        if accessToken != "" {
            return true
        }
        return false
    }
    
    func removeAll() {
        UserDefaults.standard.removeObject(forKey:  "isUserDetail")
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.userInfo.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.XAcc.rawValue)
        let domain = Bundle.main.bundleIdentifier!
        self.removePersistentDomain(forName: domain)
        self.synchronize()
    }
    
    
}
