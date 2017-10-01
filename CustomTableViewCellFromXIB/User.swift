//
//  User.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/28/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class User: NSObject {
    var name:String?
    var email:String?
    var profileImageUrl:String?
    var college:String?
    var branch:String?
    var phone:String?
}


class StudentBoard: NSObject {
    var name:String?
    var tital:String?
    var desc:String?
    var uid:String?
    var date:String?
    var category:String?
    var imageUrl:String?
}

class Comments: NSObject {
    var uid:String?
    var text:String?
    var image:String?
    var date:String?
    var name:String?
}

