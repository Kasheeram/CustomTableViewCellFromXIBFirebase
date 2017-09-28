//
//  UserInfoViewController.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/26/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameView: UIView!
    
    var name:String?
    var image:String?
    
    let userInfo = ["gandhi ji":["gandhi ji","SB Colleage of engineering","Sam_123","john@gmail.com","9971474399"],"barak ubama":["barak obama","US Colleage of engineering","barak_123","barak@gmail.com","9576474399"],"steve jobs":["steve obs","SC Colleage of engineering","steve_123","steve@gmail.com","9976474399"],"sundar pichai":["Sundar pichai","UIO Colleage of engineering","sunder_123","sunder@gmail.com","9971984399"],"modi ji":["Narendra modi","KAS Colleage of engineering","modi_123","modi@gmail.com","9971489399"]]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let button = UIButton.init(type: .custom)
        // button.setImage(UIImage.init(named: image!), for: UIControlState.normal)
        //button.addTarget(self, action:#selector(self), for: UIControlEvents.touchUpInside)
        // adding left image to barbutton item
        button.frame = CGRect.init(x: 0, y: 0, width: 35, height: 35) //CGRectMake(0, 0, 30, 30)
        let leftImageView = UIImageView(image: UIImage(named:image!))
        leftImageView.frame = CGRect(x: 0, y: 0, width: button.frame.width-5, height: button.frame.size.height-5)
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
        
        addUserInformation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addUserInformation(){
        let userInf = userInfo[name!]
        userName.text = userInf?[0]
        collegeName.text = userInf?[1]
        branchLabel.text = userInf?[2]
        emailLabel.text = userInf?[3]
        phoneLabel.text = userInf?[4]
        userProfilePic.image = UIImage(named:image!)
        userProfilePic.layer.cornerRadius = 30
        userProfilePic.layer.masksToBounds = true
        
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
