//
//  ProfileDetailsTableViewCell.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/21/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class ProfileDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postedByLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priorityImage: UIImageView!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var warningImage: UIImageView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var profilePicofCommentedUser: UIImageView!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var numberOfCommentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
