//
//  loginViewController.swift
//  myLogs
//
//  Created by Neil Hurley on 3/25/15.
//  Copyright (c) 2015 Neil Hurley. All rights reserved.
//

import Foundation

class loginViewController: UIViewController  {
    //FB ,FBLoginViewDelegate
    
    
    //FB@IBOutlet weak var fbLoginView: FBLoginView!
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
        //FBself.fbLoginView.delegate = self
        //FBself.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
    }
    
    
    //FBfunc loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        //FBprintln("User Logged In")
        //FBprintln("This is where you perform a segue.")
    //FB}
    
    //FBfunc loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){
        //FBprintln("User Name: \(user.name)")
    //FB}
    
    //FBfunc loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        //FBprintln("User Logged Out")
    //FB}
    
    //FBfunc loginView(loginView : FBLoginView!, handleError:NSError) {
        //FBprintln("Error: \(handleError.localizedDescription)")
    //FB}
    
    
}