//
//  TopicsTableViewCell.swift
//  TD assignment
//
//  Created by Sacha Sukhdeo on 2018-10-22.
//  Copyright © 2018 Sacha Sukhdeo. All rights reserved.
//

import Foundation
import UIKit

class TopicsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageArticle: TopicsImageView!
    @IBOutlet weak var title: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageArticle.contentMode = .scaleAspectFit
        detailTextLabel?.textColor = .darkGray
        textLabel?.textColor = .darkText
        backgroundColor = .clear
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(4, 8, 4, 8))
        contentView.backgroundColor = UIColor(white: 1.0, alpha: 1)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor(white: 0.3, alpha: 0.1).cgColor
    }
}
