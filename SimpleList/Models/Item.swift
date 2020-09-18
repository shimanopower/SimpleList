//
//  Item.swift
//  SimpleList
//
//  Created by shimanopower on 9/9/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

import Foundation

struct ItemData: Decodable, Hashable {
    var id: Int?
    var sectionIdentifier: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case sectionIdentifier = "listId"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int?.self, forKey: .id) ?? nil
        sectionIdentifier = try values.decodeIfPresent(Int?.self, forKey: .sectionIdentifier) ?? nil
        name = try values.decodeIfPresent(String?.self, forKey: .name) ?? nil
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ItemData, rhs: ItemData) -> Bool {
        lhs.id == rhs.id
    }
}
