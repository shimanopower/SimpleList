//
//  ItemTableViewCell.swift
//  SimpleList
//
//  Created by shimanopower on 9/18/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    var nameLabel: String? {
        didSet { titleLabel.text = nameLabel?.nameFormatted }
    }
    
    var idLabel: Int? {
        didSet { subtitleLabel.text = idLabel?.idFormatted}
    }
}
