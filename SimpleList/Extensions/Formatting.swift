//
//  Formatting.swift
//  SimpleList
//
//  Created by Tristan Jackson on 9/18/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

import Foundation

extension String {
    var nameFormatted: String {
        "Name: " + self
    }
    
    var sectionFormatted: String {
        let sectionString = String(self)
        return "List ID: " + sectionString
    }
}

extension Int {
    var idFormatted: String {
        let idString = String(self)
        return "ID: " + idString
    }
}
