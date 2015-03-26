//
//  loginViewController.swift
//  myLogs
//
//  Created by Neil Hurley on 3/25/15.
//  Copyright (c) 2015 Neil Hurley. All rights reserved.
//

import Foundation

class loginViewController: UIViewController, FBLoginViewDelegate {
    
    
    
    @IBOutlet weak var fbLoginView: FBLoginView!
    @IBOutlet weak var loginInitialLabel: UILabel!
    @IBOutlet weak var logInSavePassLabel: UILabel!
    
    @IBOutlet weak var loginInUserTextField: UITextField!
    @IBOutlet weak var logInPassTextField: UITextField!
    
    @IBOutlet weak var logInSavePassSwitch: UISwitch!
    
    @IBAction func logInActionButton(sender: AnyObject) {
        
        if loginInUserTextField.text != "" && logInPassTextField.text != "" {
            // Not Empty, Do something.
            if logInSavePassSwitch.on {
                // If the user has selected YES to saving password
                println(loginInUserTextField.text)
                println(logInPassTextField.text)
                PFUser.logInWithUsernameInBackground(loginInUserTextField.text, password:logInPassTextField.text) {
                    (user: PFUser!, error: NSError!) -> Void in
                    if user != nil {
                        // Yes, User Exists
                        self.loginInitialLabel.text = "User Exists"
                    } else {
                        // No, User Doesn't Exist
                    }
                }
            } else {
                // If the user has selected NO to saving password
            }
        } else {
            // Empty, Notify user
            self.loginInitialLabel.text = "All Fields Required"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
    }
    
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
        println("This is where you perform a segue.")
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){
        println("User Name: \(user.name)")
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }
    
    
}