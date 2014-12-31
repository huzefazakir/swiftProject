//
//  UserNotificationTableViewController.swift
//  Likey
//
//  Created by Nafisa Moochhala on 12/6/14.
//  Copyright (c) 2014 self. All rights reserved.
//

import UIKit

class UserNotificationTableViewController: UITableViewController, PopUpMenuDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var popUpMenu:PopUpMenu = PopUpMenu()

    @IBOutlet weak var usernameLabel: UILabel! = UILabel()
    
    @IBOutlet weak var editImage: UIButton! = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpMenu = PopUpMenu(sourceView: self.view, menuItems: ["Take Photo", "Choose From Library", "Cancel"])
        popUpMenu.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (PFUser.currentUser() != nil) {
            usernameLabel.alpha = 0
            
            self.usernameLabel.text = PFUser.currentUser().username as String
            //usernameLabel.text = "testing"
            
            var findUser:PFQuery = PFUser.query()
            findUser.whereKey("username", equalTo: PFUser.currentUser().username)
            
            findUser.findObjectsInBackgroundWithBlock{
                (objects:[AnyObject]!, error:NSError!)->Void in
                if (error == nil) {
                    let user:PFUser = (objects as NSArray).lastObject as PFUser
                    let profileImage:PFFile = user["profileImage"] as PFFile
                    
                    profileImage.getDataInBackgroundWithBlock{
                        (imageData:NSData!, error:NSError!) ->Void in
                        
                        if(error == nil) {
                            let image:UIImage! = UIImage(data: imageData)
                            self.editImage.setBackgroundImage(image, forState: UIControlState.Normal)
                        } else {
                            println("error2")
                        }
                    }
                    
                } else {
                    println("error1")
                }
            }
            
            UIView.animateWithDuration(0.5, animations: {
                self.usernameLabel.alpha = 1
            })
            
        } else {
            println("user not logged in")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    
    
    

    @IBAction func editImageAction(sender: AnyObject) {
        
        popUpMenu.showPopUpMenu(true)
    }

    @IBAction func Logout(sender: AnyObject) {
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    func popUpMenuDidSelectButtonAtIndex(index: Int) {
        if (index  == 0){
            
        }else if (index == 1) {
            var imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.delegate = self
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }else{
            popUpMenu.showPopUpMenu(false)
        }
    
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let pickedImage:UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
        let scaledImage = self.scaleImageWith(pickedImage, and: CGSizeMake(100, 100))
        let imageData = UIImagePNGRepresentation(scaledImage)
        let imageFile:PFFile = PFFile(data: imageData)
        
        PFUser.currentUser().setObject(imageFile, forKey: "profileImage")
        PFUser.currentUser().saveInBackgroundWithBlock{
            (success:Bool!, error:NSError!)->Void in
            
            if(error == nil) {
                self.editImage.setBackgroundImage(scaledImage, forState: UIControlState.Normal)
                self.popUpMenu.showPopUpMenu(false)
            } else {
                println(error.description)
            }
            
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scaleImageWith(image:UIImage, and newSize:CGSize )->UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
    }

}