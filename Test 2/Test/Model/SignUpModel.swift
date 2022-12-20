//
//  SignUpModel.swift
//  Test
//
//  Created by Minh on 21/11/2022.
//

import Foundation
struct SignUpModel : Codable {
    let _id : String?
    let email : String?
    let admin : Bool?
    let firstName : String?
    let lastName : String?
    let createdAt : String?
    let updatedAt : String?
    let __v : Int?
    let displayName : String?
    let token : String?
    let refreshToken : String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case email = "email"
        case admin = "admin"
        case firstName = "firstName"
        case lastName = "lastName"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case __v = "__v"
        case displayName = "displayName"
        case token = "token"
        case refreshToken = "refreshToken"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        admin = try values.decodeIfPresent(Bool.self, forKey: .admin)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
        displayName = try values.decodeIfPresent(String.self, forKey: .displayName)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        refreshToken = try values.decodeIfPresent(String.self, forKey: .refreshToken)
    }

}
