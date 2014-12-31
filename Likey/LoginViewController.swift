//
//  LoginViewController.swift
//  Likey
//
//  Created by Nafisa Moochhala on 11/28/14.
//  Copyright (c) 2014 self. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField! = UITextField()
    
    @IBOutlet weak var passwordTextField: UITextField! = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(emailTextField.text, password: passwordTextField.text){
            (user:PFUser!, error:NSError!)->Void in
            if ((user) != nil) {
                println("login successful")
                self.performSegueWithIdentifier("loggedIn", sender: self)
            } else {
                println("login failed")
                println(error.description)
            }
        }
        
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
