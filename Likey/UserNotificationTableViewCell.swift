//
//  UserNotificationTableViewCell.swift
//  Likey
//
//  Created by Nafisa Moochhala on 12/31/14.
//  Copyright (c) 2014 self. All rights reserved.
//

import UIKit

class UserNotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationTime: UILabel! = UILabel()
    @IBOutlet weak var notificationLabel: UILabel! = UILabel()
        override func awakeFromNib() {
        super.awakeFromNib()
        //notificationImage.layer.cornerRadius = notificationImage.frame.size.height/2
    }

    
    @IBOutlet weak var notificationImage: UIImageView! = UIImageView()
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
