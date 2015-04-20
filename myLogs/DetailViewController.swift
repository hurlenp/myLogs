//
//  DetailViewController.swift
//  myLogs
//
//  Created by Neil Hurley on 3/18/15.
//  Copyright (c) 2015 Neil Hurley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Container to store the view table selected object
    var currentObject : PFObject?
    
    let service = "swiftLogin"
    let userAccount = "swiftLoginUser"
    var username: AnyObject?
    
    
    
    // Some text fields
    @IBOutlet weak var logID: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var status: UITextField!
    @IBOutlet weak var logLabel: UILabel!
    
    @IBAction func clearKeychain(sender: AnyObject) {
        Locksmith.clearKeychain()
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        // Unwrap the current object object
        if let object = currentObject? {
            var stringNumber: String = logID.text
            var log = stringNumber.toInt()
            object["logID"] = log
            object["location"] = location.text?
            object["comment"] = status.text?
            
            // Save the data back to the server in a background task
            //object.saveEventually(nil)
            
            object.save()
            
        } else {
            var object = PFObject(className: "myLogTest")
            //object.addObject(location.text as String, forKey: "location")
            //object.addObject(status.text as String, forKey: "comment")
            object.setObject("\(location.text)", forKey: "location")
            object.setObject("\(status.text)", forKey: "comment")
            object.setObject(username, forKey: "username")
            let now = NSDate()
            object.setObject(now, forKey: "logDate")
            // Delete the ones below when you figure out what they'll mess up
            object.setObject(999, forKey: "logID")
            object.setObject("Test", forKey: "logType")
            object.setObject("Test", forKey: "logSubType")
            
            

            object.save()
        }
        
        // Return to table view
        self.navigationController?.popViewControllerAnimated(true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Unwrap the current object object
        var log: Int
        if let object = currentObject? {
            log = object["logID"] as Int
            logID.text = String(log)
            location.text = object["location"] as String
            status.text = object["comment"] as String
            logLabel.hidden = true
        } else {
            logID.text = "new log"
            logLabel.hidden = false
        }
    }
   
    override func viewDidAppear(animated: Bool) {
        let (dictionary, error) = Locksmith.loadDataForUserAccount(userAccount, inService: service)
        if let dictionary = dictionary {
            
            username = dictionary["username"]!
            println(username)
        } else {
            println("not logged in")
            // Not logged in, send to login view controller
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
