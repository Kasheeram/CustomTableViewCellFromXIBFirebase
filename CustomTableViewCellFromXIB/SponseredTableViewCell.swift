//
//  SponseredTableViewCell.swift
//  CustomTableViewCellFromXIB
//
//  Created by LinuxPlus on 9/24/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class SponseredTableViewCell: UITableViewCell {
    @IBOutlet weak var sponseredButton: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
