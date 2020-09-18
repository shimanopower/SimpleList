//
//  Section.swift
//  SimpleList
//
//  Created by shimanopower on 9/18/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

//import UIKit
//
//class Section: Hashable, Comparable {
//    var sectionTitle: String
//    var items: [ItemData]
//    static private var sectionTitles = [String]()
//    
//    init(with title: String, from items: [ItemData]) {
//        self.sectionTitle = title
//        self.items = items
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(sectionTitle)
//    }
//    
//    static func == (lhs: Section, rhs: Section) -> Bool {
//        lhs.sectionTitle == rhs.sectionTitle
//    }
//    
//    static func < (lhs: Section, rhs: Section) -> Bool {
//        return lhs.sectionTitle < rhs.sectionTitle
//    }
//}


//class MyDataSource: UITableViewDiffableDataSource<Section, ItemData> {
//  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
////    let cell = tableView.dequeueReusableCell(withIdentifier: "")
//    return "Section Title"
//  }
//}

