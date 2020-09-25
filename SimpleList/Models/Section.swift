//
//  Section.swift
//  SimpleList
//
//  Created by Tristan Jackson on 9/21/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

import Foundation

class Section: Hashable {
    var id = UUID()
    private var title: String
    var items: [ItemData]

    static var sections = [Section]()
    
    var section: String {
        title
    }
  
    init(title: String, items: [ItemData]) {
        self.title = title
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }

    func filterItems(_ search: String) -> [ItemData] {
        self.items.filter { $0.id! == Int(search) || String($0.id!).hasPrefix(search) }
    }
}
