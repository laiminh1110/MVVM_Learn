//
//  CategoriesListModel.swift
//  Test
//
//  Created by Minh on 21/11/2022.
//

import Foundation
struct CategoriesListModel : Codable {
    let categories : [Categories]?
    let totalCount : Int?

    enum CodingKeys: String, CodingKey {
        case categories = "categories"
        case totalCount = "totalCount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
    }

}

struct Categories : Codable {
    let _id : String?
    let name : String?

    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
