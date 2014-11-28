//
//  TimeLineTableViewController.swift
//  Likey
//
//  Created by Nafisa Moochhala on 11/18/14.
//  Copyright (c) 2014 self. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {
    
    var timelineData:NSMutableArray = NSMutableArray()
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func loadData(){
        println("load data")
        timelineData.removeAllObjects()
        
        var findTimeLineData:PFQuery = PFQuery(className: "_User")
        
        findTimeLineData.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            
            if (error == nil){
                for object in objects {
                    self.timelineData.addObject(object)
                }
            } else {
                println("error occurred")
            }
            
            self.tableView.reloadData()
        
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if ((PFUser.currentUser()) == nil) {
            var loginAlert:UIAlertController = UIAlertController(title: "Sign Up / login", message: "Please sign up or login", preferredStyle: UIAlertControllerStyle.Alert)
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Your username"
            })
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Your password"
                textfield.secureTextEntry = true
            })
            
            loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                let textFields:NSArray = loginAlert.textFields! as NSArray
                let usernameTextField = textFields.objectAtIndex(0) as UITextField
                let passwordTextField = textFields.objectAtIndex(1) as UITextField
                
                PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text){
                    (user:PFUser!, error:NSError!)->Void in
                    if ((user) != nil) {
                        println("login successful")
                        self.loadData()
                    } else {
                        println("login failed")
                        println(error.description)
                    }
                }
                
            }))
            
            loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                let textFields:NSArray = loginAlert.textFields! as NSArray
                let usernameTextField = textFields.objectAtIndex(0) as UITextField
                let passwordTextField = textFields.objectAtIndex(1) as UITextField
                
                var user:PFUser = PFUser()
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackgroundWithBlock{
                    (success:Bool!, error:NSError!)->Void in
                    if (error == nil){
                        println("Sign Up successful")
                        self.loadData()
                    } else {
                        let errorString = error.description
                        println(error.description)
                    }
                    
                }
                
            }))

            self.presentViewController(loginAlert, animated: true, completion:nil)
        } else {
            self.loadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerClass(exploreTableViewCell.classForCoder(), forCellReuseIdentifier: Cell)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return timelineData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:exploreTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as exploreTableViewCell
        let person:PFObject = self.timelineData.objectAtIndex(indexPath.row) as PFObject
        
        
        cell.usernameLabel.alpha = 0
        cell.usernameLabel.text = person.objectForKey("username") as? String
        
        UIView.animateWithDuration(0.5, animations: {
            cell.usernameLabel.alpha = 1;
        })

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
