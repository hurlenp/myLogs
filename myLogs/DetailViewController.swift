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
    
    
    
    // Some text fields
    @IBOutlet weak var logID: UITextField!
    @IBOutlet weak var logType: UITextField!
    @IBOutlet weak var logSubType: UITextField!
    
    
    @IBAction func saveButton(sender: AnyObject) {
        // Unwrap the current object object
        if let object = currentObject? {
            var stringNumber: String = logID.text
            var log = stringNumber.toInt()
            object["logID"] = log
            object["logType"] = logType.text
            object["logSubType"] = logSubType.text
            
            // Save the data back to the server in a background task
            //object.saveEventually(nil)
            
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
            logType.text = object["logType"] as String
            logSubType.text = object["logSubType"] as String

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
