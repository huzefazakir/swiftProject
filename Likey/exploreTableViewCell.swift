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
    
    @IBOutlet weak var profileImageView: UIImageView! = UIImageView()
    
    
    var originalCellCenter = CGPoint()
    var originalImageCenter = CGPoint()
    var likedImageCenter = CGPoint()
    var likedState = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        self.profileImageView.addGestureRecognizer(recognizer)
        originalImageCenter = self.profileImageView.center
        likedImageCenter.x = originalImageCenter.x + 200
        likedImageCenter.y = originalImageCenter.y
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer){
        
        if recognizer.state == .Began {
            
        }
        
        if recognizer.state == .Changed {
            let translation = recognizer.translationInView(self)
            self.profileImageView.center = CGPointMake(originalImageCenter.x + translation.x, originalImageCenter.y)
            likedState = self.profileImageView.center.x > -frame.size.width/2.0
        }
        
        if recognizer.state == .Ended {
            if (!likedState) {
                UIView.animateWithDuration(0.2, animations: {self.profileImageView.center = self.originalImageCenter})
            } else {
                UIView.animateWithDuration(0.2, animations: {self.profileImageView.center = self.likedImageCenter})
                swap(&originalImageCenter, &likedImageCenter)
            }
        }
        
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if (fabs(translation.x) > fabs(translation.y)) {
                return true
            }
            return false
        }
        return false
    }
    
    

}
