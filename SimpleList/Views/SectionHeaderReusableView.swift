//
//  SectionHeaderReusableView.swift
//  SimpleList
//
//  Created by shimanopower on 9/12/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

//import UIKit
//
//class SectionHeaderView: UITableViewHeaderFooterView {
//    static var reuseIdentifier: String {
//        return String(describing: SectionHeaderView.self)
//    }
//    
//    lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
//        label.adjustsFontForContentSizeCategory = true
//        label.textColor = .label
//        label.textAlignment = .left
//        label.numberOfLines = 1
//        label.setContentCompressionResistancePriority(
//        .defaultHigh, for: .horizontal)
//        return label
//    }()
//    
//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        
//        backgroundColor = .systemBackground
//        addSubview(titleLabel)
//        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
//            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: readableContentGuide.trailingAnchor),
//            titleLabel.topAnchor.constraint(equalTo: topAnchor,
//              constant: 10),
//            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
//              constant: -10)
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
