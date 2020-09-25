//
//  Item.swift
//  SimpleList
//
//  Created by shimanopower on 9/18/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

import Foundation

struct ItemData: Decodable, Hashable, Comparable {
    var id: Int?
    var sectionIdentifier: Int?
    var name: String

    enum CodingKeys: String, CodingKey {
        case id
        case sectionIdentifier = "listId"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int?.self, forKey: .id) ?? nil
        sectionIdentifier = try values.decodeIfPresent(Int?.self, forKey: .sectionIdentifier) ?? nil
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ItemData, rhs: ItemData) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: ItemData, rhs: ItemData) -> Bool {
        guard let leftSection = lhs.sectionIdentifier, let rightSection = rhs.sectionIdentifier else { return false }
        if leftSection < rightSection { return true }
        else {
            let lFilter = lhs.name.filter { $0.isNumber }
            let rFilter = rhs.name.filter { $0.isNumber }
            let lInt = Int(lFilter) ?? 0
            let rInt = Int(rFilter) ?? 0
            
            return leftSection == rightSection && lInt < rInt }
    }
}
