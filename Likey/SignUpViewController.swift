//
//  SignUpViewController.swift
//  Likey
//
//  Created by Nafisa Moochhala on 11/28/14.
//  Copyright (c) 2014 self. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var firstNameTextField: UITextField! = UITextField()
    @IBOutlet weak var lastNameTextField: UITextField! = UITextField()
    @IBOutlet weak var emailTextField: UITextField! = UITextField()
    @IBOutlet weak var passwordTextField: UITextField! = UITextField()
    @IBOutlet weak var confrimPasswordTextField: UITextField! = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
        // validation code goes here
        
        var user:PFUser = PFUser()
        // also save the first name and last name of the user
        user.username = emailTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackgroundWithBlock{
            (success:Bool, error:NSError!)->Void in
            if (error == nil){
                println("Sign Up successful")
                var imagePicker:UIImagePickerController = UIImagePickerController()
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.delegate = self
                self.presentViewController(imagePicker, animated: true, completion: nil)
            } else {
                let errorString = error.description
                println(error.description)
            }
        }
        

        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let pickedImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let scaledImage = self.scaleImageWith(pickedImage, and: CGSizeMake(100, 100))
        let imageData = UIImagePNGRepresentation(scaledImage)
        let imageFile:PFFile = PFFile(data: imageData)
        
        PFUser.currentUser().setObject(imageFile, forKey: "profileImage")
        PFUser.currentUser().saveInBackgroundWithBlock{
            (success:Bool, error:NSError!)->Void in
            
            if(error == nil) {
                self.performSegueWithIdentifier("signedUp", sender: self)
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
