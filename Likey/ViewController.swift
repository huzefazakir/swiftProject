//
//  ViewController.swift
//  Likey
//
//  Created by Nafisa Moochhala on 11/17/14.
//  Copyright (c) 2014 self. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PopUpMenuDelegate {

    var popUpMenu:PopUpMenu = PopUpMenu()

    override func viewDidLoad() {
        super.viewDidLoad()
        popUpMenu = PopUpMenu(sourceView: self.view, menuItems: ["first", "second", "third"])
        popUpMenu.delegate = self
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func popUpMenuDidSelectButtonAtIndex(index: Int) {

    }
   
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func editImage(sender: AnyObject){
        popUpMenu.showPopUpMenu(true)
        
    }
    
    
}

