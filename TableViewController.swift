//
//  TableViewController.swift
//  myLogs
//
//  Created by Neil Hurley on 3/13/15.
//  Copyright (c) 2015 Neil Hurley. All rights reserved.
//

import UIKit

class TableViewController: PFQueryTableViewController {
    
    var sections = [String : Array<Int>]()
    var sectionToDateMap = NSMutableDictionary()
    var comment: String?
    let service = "swiftLogin"
    let userAccount = "swiftLoginUser"
    let key = "RandomKey"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register Custom Cell
        var nib = UINib(nibName: "vwLogCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "logCell")
        
        
    }
    
    
    // Initialise the PFQueryTable tableview
    override init!(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "myLogTest"
        self.textKey = "logType"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 20 //uncomment this to get all rows
    }

    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: "myLogTest")
        //query.whereKey("logID", equalTo: 1)
        query.orderByDescending("logDate")
        
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject) -> PFTableViewCell {
        //var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as PFTableViewCell!
        var cell = tableView.dequeueReusableCellWithIdentifier("logCell") as TblCell!
        if cell == nil {
            cell = TblCell(style: UITableViewCellStyle.Default, reuseIdentifier: "logCell")
        }
        
        // Extract values from the PFObject to display in the table cell
        
        //var logTime = object.createdAt as NSDate!
        var logTime = object["logDate"] as NSDate!
     
        cell.lblUser.text = object["username"] as String!
        cell.lblLocation.text = object["location"] as String!
        comment = object["comment"] as String!
        cell.lblComment.text = comment
        
        cell.imgUser.image = UIImage(named: object["username"] as String!)
        let img = cell.imgUser.image
        cell.imgUser.image = img?.cropToCircleWithBorderColor(UIColor(red: 0.91, green: 0.34, blue: 0.16, alpha: 1.00), lineWidth: 20)
        
        let timeSincePoop: String = timeAgoSinceDate(logTime, numericDates: true)
        cell.lblLogTime.text = "Logged a poop " + timeSincePoop
        
        if comment == nil {
            cell.vwComment.hidden = true
        } else {
            cell.vwComment.hidden = false
        }   
        
        return cell
    }
    
    func DateToSection(section: NSInteger) -> NSString {
        
        return sectionToDateMap.objectForKey(section) as NSString
    }
    
    override func objectsDidLoad(error: NSError!) {
        
        super.objectsDidLoad(error)
        
        
        
        sections.removeAll(keepCapacity: false)
        
        sectionToDateMap.removeAllObjects()
        
        
        
        var section = 0
        
        var rowIndex = 0
        
        
        
        for object in objects {
            
            
            let date = object["username"] as String
            
            var objectsInSection = sections[date]
            
            
            
            if (objectsInSection == nil) {
                
                objectsInSection = Array<Int>()
                
                sectionToDateMap[section++] = date
                
            }
            
            objectsInSection?.append(rowIndex++)
            
            sections[date] = objectsInSection
            
        }
        
        tableView.reloadData()
        
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject! {
        
        let date = DateToSection(indexPath.section)
        
        let rows = sections[date]!
        
        let rowIndex = rows[indexPath.row]
        
        
        
        return objects[rowIndex] as PFObject
        
        
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        println(sections.count)
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let date = DateToSection(section)
        
        let rowIndecesInSection = sections[date]!
        
        return rowIndecesInSection.count
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let date = DateToSection(section)
        
        return date
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.delegate = self
        super.tableView(tableView, didDeselectRowAtIndexPath: indexPath)
        //super.tableView(<#tableView: UITableView#>, didDeselectRowAtIndexPath: <#NSIndexPath#>)
        
        let selectedObject = self.objectAtIndexPath(indexPath)
        
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //if comment == nil {
        //return 97
        //} else {
        return 118
        //}
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 95/255, green: 138/255, blue: 171/255, alpha: 1.0) //make the background color dark blue
        header.textLabel.textColor = UIColor.whiteColor() //make the text white
        header.alpha = 1.0 //make the header transparent
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        var detailScene = segue.destinationViewController as DetailViewController
        
        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let row = Int(indexPath.row)
            detailScene.currentObject = objects[row] as? PFObject
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //let (dictionary, error) = Locksmith.loadData(forKey: key, inService: service, forUserAccount: userAccount)
        
        /*
        let (dictionary, error) = Locksmith.loadDataForUserAccount(userAccount, inService: service)
        if let dictionary = dictionary {
            
            // User is already logged in, Send them to already logged in view.
            
        } else {
            self.performSegueWithIdentifier("logInViewSegue", sender: self)
            // Not logged in, send to login view controller
            
        }
        */

        tableView.reloadData()
    }
    
    
    func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.currentCalendar()
        let unitFlags = NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekOfYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitSecond
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components(unitFlags, fromDate: earliest, toDate: latest, options: nil)
        
        if (components.year >= 2) {
            return "\(components.year) years ago"
        } else if (components.year >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month >= 2) {
            return "\(components.month) months ago"
        } else if (components.month >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear >= 2) {
            return "\(components.weekOfYear) weeks ago"
        } else if (components.weekOfYear >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day >= 2) {
            return "\(components.day) days ago"
        } else if (components.day >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour >= 2) {
            return "\(components.hour) hours ago"
        } else if (components.hour >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute >= 2) {
            return "\(components.minute) minutes ago"
        } else if (components.minute >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second >= 3) {
            return "\(components.second) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
    
}