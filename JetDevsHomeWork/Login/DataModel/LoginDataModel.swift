//
//  LoginDataModel.swift
//  JetDevsHomeWork
//
//  Created by Hemang Solanki on 14/12/22.
//

import Foundation


// MARK: - UserModel

struct UserModel: Codable {
    
    let result: Int?
    let errorMessage: String?
    let data: UserData?

    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
        case data
    }
}

// MARK: - userData

struct UserData: Codable {
    
    let user: User?
}

// MARK: - User

struct User: Codable {
    
    let userID: Int?
    let userName: String?
    let userProfileURL: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userProfileURL = "user_profile_url"
        case createdAt = "created_at"
    }
}
