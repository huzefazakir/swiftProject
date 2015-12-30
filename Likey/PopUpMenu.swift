//
//  popUpMenu.swift
//  Likey
//
//  Created by Nafisa Moochhala on 11/30/14.
//  Copyright (c) 2014 self. All rights reserved.
//

import UIKit

@objc protocol PopUpMenuDelegate{
    func popUpMenuDidSelectButtonAtIndex(index:Int)
    optional func popUpMenuWillClose()
    optional func popUpMenuWillOpens()
    
}

class PopUpMenu: NSObject, PopUpTableViewControllerDelegate {
    
    let popUpMenuHeight:CGFloat = 150.0
    let popUpMenuTableViewBottomInsert:CGFloat = 64.0
    let popUpMenuContainerView = UIView()
    let popUpMenuTableViewController:PopUpTableViewController = PopUpTableViewController()
    var originView:UIView!
    
    var animator:UIDynamicAnimator!
    var delegate:PopUpMenuDelegate?
    var isPopUpMenuOpen:Bool = false
    
    
    override init(){
        super.init()
    }
    
    init(sourceView:UIView, menuItems:Array<String>){
        
        super.init()
        originView = sourceView
        popUpMenuTableViewController.tableData = menuItems
        
        
        
        animator = UIDynamicAnimator(referenceView: originView)
        
        setUpPopUpMenu()
        
        
    }
    
    func setUpPopUpMenu(){
        
        popUpMenuContainerView.frame = CGRectMake(originView.frame.origin.x, -popUpMenuHeight-1, originView.frame.size.width, popUpMenuHeight)
        popUpMenuContainerView.backgroundColor = UIColor.clearColor()
        popUpMenuContainerView.clipsToBounds = false
        
        originView!.addSubview(popUpMenuContainerView)
        
        let blurView:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        blurView.frame = popUpMenuContainerView.bounds
        popUpMenuContainerView.addSubview(blurView)
        
        popUpMenuTableViewController.delegate = self
        popUpMenuTableViewController.tableView.frame = popUpMenuContainerView.bounds
        popUpMenuTableViewController.tableView.clipsToBounds = false
        popUpMenuTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        popUpMenuTableViewController.tableView.backgroundColor = UIColor.clearColor()
        popUpMenuTableViewController.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        popUpMenuTableViewController.tableView.reloadData()
        
        popUpMenuContainerView.addSubview(popUpMenuTableViewController.tableView)
        
    }
    
    
    func showPopUpMenu(shouldOpen:Bool) {
        animator.removeAllBehaviors()
        isPopUpMenuOpen = shouldOpen
        
        let gravityY:CGFloat = (shouldOpen) ? 0.9 : -0.9
        let magnitude:CGFloat = (shouldOpen) ? 5 : -5
        let boundryY:CGFloat = (shouldOpen) ? popUpMenuHeight : -popUpMenuHeight-1
        
        let gravityBehaviour:UIGravityBehavior = UIGravityBehavior(items: [popUpMenuContainerView])
        gravityBehaviour.gravityDirection = CGVectorMake(0, gravityY)
        animator.addBehavior(gravityBehaviour)
        
        let collisionBehavior:UICollisionBehavior = UICollisionBehavior(items: [popUpMenuContainerView])
        collisionBehavior.addBoundaryWithIdentifier("popUpMenuBoundary", fromPoint: CGPointMake(0, boundryY), toPoint: CGPointMake(originView!.frame.size.width, boundryY))
        animator.addBehavior(collisionBehavior)
        
    }
    
    
    
    func popUpControlDidSelectRow(indexPath: NSIndexPath) {
        delegate?.popUpMenuDidSelectButtonAtIndex(indexPath.row)
    }
   
}
