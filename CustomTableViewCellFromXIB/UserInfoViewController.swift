//
//  UserInfoViewController.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/26/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit
import Firebase

class UserInfoViewController: UIViewController {
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var popUpView: UIView!
    
    var uid:String?    
    let ref = Database.database().reference()
    let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.layer.cornerRadius = 10;
        popUpView.layer.masksToBounds = true
        
        ref.child("Users").child(uid!).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                self.user.setValuesForKeys(dictionary)
                print("1234\(self.user.name)")
            }
            
            self.addImagetoNavBar()
            self.addUserInformation()
        })
        
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addUserInformation(){
        userName.text = user.name
        collegeName.text = user.college
        branchLabel.text = user.branch
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        if let profileImageUrl = user.profileImageUrl {
            userProfilePic.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
        userProfilePic.layer.cornerRadius = 30
        userProfilePic.layer.masksToBounds = true
        
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
       // navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func addImagetoNavBar(){
        
        let button = UIButton.init(type: .custom)
        // button.setImage(UIImage.init(named: image!), for: UIControlState.normal)
        //button.addTarget(self, action:#selector(self), for: UIControlEvents.touchUpInside)
        // adding left image to barbutton item
        button.frame = CGRect.init(x: 0, y: 0, width: 35, height: 35) //CGRectMake(0, 0, 30, 30)
        let leftImageView = UIImageView(image: UIImage(named:"gandhi"))
        leftImageView.frame = CGRect(x: 0, y: 0, width: button.frame.width-5, height: button.frame.size.height-5)
        
        if let profileImageUrl = user.profileImageUrl {
            leftImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
        button.addSubview(leftImageView)
        
        button.imageView?.contentMode = .scaleAspectFill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: button.frame.width - (button.imageView?.frame.width)!)
        // adding right image to barbutton item
        let rightImageView = UIImageView(image: UIImage(named:"drop"))
        rightImageView.tintColor = UIColor.blue
        let height = button.frame.height * 0.3
        let width = height
        let xPos = button.frame.width - width
        let yPos = (button.frame.height - height) / 1
        rightImageView.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        button.addSubview(rightImageView)
        leftImageView.layer.cornerRadius = 15
        leftImageView.layer.masksToBounds = true
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: nameView.frame.height - 1, width: nameView.frame.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        nameView.layer.addSublayer(bottomLine)

    }
    
    
    
}
