//
//  UniversityTableViewCell.swift
//  CustomTableViewCellFromXIB
//
//  Created by LinuxPlus on 9/19/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class UniversityTableViewCell: UITableViewCell {

    @IBOutlet weak var txtLabel: UILabel!
    @IBOutlet weak var postedByLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
