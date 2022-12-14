//
//  LoginViewModel.swift
//  JetDevsHomeWork
//
//  Created by Hemang Solanki on 14/12/22.
//

import Foundation
import UIKit

class LoginViewModel {
    
    var loginData: UserModel?
    var user: User?
    
    // MARK: - Helper / Validation
    func checkValidations(email: String, password: String) -> (Bool, String) {
        if email.count == 0 { return (false, "Email address can not be blank") } else if email.isValidEmail() == false { return (false, "Email address is not valid") } else if password.isEmpty == true { return (false, "Password can not be blank") } else if (password.count < 8) == true { return (false, "Password must have at least 8 character") }
        return (true, "Validate successfully")
    }
    
    func loginApi(email: String, password: String, completionHandler: @escaping ( UserModel ) -> (Void), errorHandler: @escaping ( String ) -> (Void)) {
        
        let parameters = "{\n\"email\":\"\(email)\",\n\"password\":\"\(password)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://jetdevs.mocklab.io/login")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8) ?? "")
            print(response!)
            if let httpResponse = response as? HTTPURLResponse {
                if let XAcc = httpResponse.allHeaderFields["X-Acc"] as? String {
                    print("X-Acc: ", XAcc)
                    // saving X-Acc locally in userDefaults.
                    UserDefaults.standard.removeObject(forKey: UserDefaultsKey.XAcc.rawValue)
                    UserDefaults.standard.accessToken = XAcc
                    UserDefaults.standard.synchronize()
                }
            }
            do {
                let user = try JSONDecoder().decode(UserModel.self, from: data)
                self.loginData = user
                self.user = user.data?.user
                if self.user != nil{
                    // saving User info locally in userDefaults.
                    UserDefaults.standard.removeObject(forKey: UserDefaultsKey.userInfo.rawValue)
                    UserDefaults.standard.setUserInfo(user: self.user!)
                    UserDefaults.standard.synchronize()
                }
                completionHandler(self.loginData!)
            } catch {
                print("errorMsg")
                errorHandler(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
