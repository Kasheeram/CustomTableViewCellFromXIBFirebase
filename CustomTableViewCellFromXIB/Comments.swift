//
//  Comments.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/21/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import Foundation


class dataComment{
    var datacomment:[cmtData]?
    
   func putdata(datacomment:[cmtData]) {
        self.datacomment = datacomment
    }
    
    func getData()->[cmtData]{
        return datacomment!
    }
}


