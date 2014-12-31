//
//  PopUpTableViewController.swift
//  Likey
//
//  Created by Nafisa Moochhala on 11/30/14.
//  Copyright (c) 2014 self. All rights reserved.
//

import UIKit

protocol PopUpTableViewControllerDelegate{
    func popUpControlDidSelectRow(indexPath:NSIndexPath)
}

class PopUpTableViewController: UITableViewController {
    
    var delegate:PopUpTableViewControllerDelegate?
    var tableData:Array<String> = []

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
                return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("menuCell") as? UITableViewCell
        
        if (cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "menuCell")
            cell!.backgroundColor = UIColor.clearColor()
            //cell!.textLabel.textColor = UIColor.darkGrayColor()
            cell!.textLabel?.textColor = UIColor.darkGrayColor()
            
            let selectedView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
            selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            
            cell!.selectedBackgroundView = selectedView
            
        }
        
        cell!.textLabel?.text = tableData[indexPath.row]
        

        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45.0
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.popUpControlDidSelectRow(indexPath)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
