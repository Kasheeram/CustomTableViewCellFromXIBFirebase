//
//  CommentsTableViewCell.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/21/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var commentLabe: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
