//
//  SettingsViewController.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 10/4/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var TCButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        borderAtTopToButton(btn:settingsButton)
        borderAtTopToButton(btn:TCButton)
        borderAtTopToButton(btn:logoutButton)
        self.profileView.layer.borderWidth = 1
       // self.profileView.layer.borderColor = UIColor.init(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        self.profileView.layer.borderColor = UIColor.lightGray.cgColor
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        //view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    func borderAtTopToButton(btn:UIButton)
    {
        var lineView = UIView(frame: CGRect(x: 0,y: 0, width: btn.frame.size.width,height: 1))
        lineView.backgroundColor=UIColor.lightGray
        btn.addSubview(lineView)
    }
}
