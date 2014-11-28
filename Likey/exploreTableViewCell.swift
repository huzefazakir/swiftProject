//
//  exploreTableViewCell.swift
//  Likey
//
//  Created by Nafisa Moochhala on 11/18/14.
//  Copyright (c) 2014 self. All rights reserved.
//

import UIKit

class exploreTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel! = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
