//
//  RegisterViewController.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/28/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpass: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var collegeName: UITextField!
    @IBOutlet weak var branchName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //profileImageView.translateAutoresizingMaskIntoConstraints = false
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target:self,action: #selector(handleSelectProfileImageView)))
       // profileImageView.userInterationEnabled = true
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        regiseterHandler(name:userName.text!,email:emailId.text!,college:collegeName.text!,branch:branchName.text!,phone:phoneNumber.text!)
}

}
