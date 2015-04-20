//
//  TblCell.swift
//  myLogs
//
//  Created by Neil Hurley on 3/24/15.
//  Copyright (c) 2015 Neil Hurley. All rights reserved.
//

import UIKit

class TblCell: PFTableViewCell {
    
    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lblUser: UILabel!
    
    @IBOutlet weak var lblLogTime: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblComment: UILabel!
    
    @IBOutlet weak var vwComment: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
