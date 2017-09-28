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

class RegisterViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpass: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //profileImageView.translateAutoresizingMaskIntoConstraints = false
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target:self,action: #selector(handleSelectProfileImageView)))
       // profileImageView.userInterationEnabled = true
    }
    
    func handleSelectProfileImageView(){
      print(123)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        if isValidEmail(testStr: emailId.text!) && (password.text?.characters.count)! > 0 {
            if password.text! != confirmpass.text! {
                let alertController = UIAlertController(title: "Error", message: "confirm password is not same as password", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                
                Auth.auth().createUser(withEmail: emailId.text!, password: password.text!) { (user, error) in
                    if error == nil {
                        // Toast(text: "You have sucessfully created your account").show()
                        guard let uid = user?.uid else{
                            return
                        }
                        let ref = Database.database().reference(fromURL: "https://basicspace-63da9.firebaseio.com/")
                        let users = ref.child("Users").child(uid)
                       // let message = ref.child("Messages")

                        let values = ["name":self.userName.text,"email":self.emailId.text]
                        users.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            if err != nil{
                                print(err)
                                return
                            }
                        })
                        
//                        message.updateChildValues(["tital":"comments"], withCompletionBlock: { (err, ref) in
//                            if err != nil{
//                                print(err)
//                                return
//                            }
//                        })
                        
                        
//                        let formatter = DateFormatter()
//                        // initially set the format based on your datepicker date
//                        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
//                        let myString = formatter.string(from: Date())
//                        // convert your string to date
//                        let yourDate = formatter.date(from: myString)
//                        //then again set the date format whhich type of output you need
//                        formatter.dateFormat = "dd-MMM-yyyy"
//                        // again convert your date to string
//                        let myStringafd = formatter.string(from: yourDate!)
//                        
//                        let employeeCheck = ref.child("Employees").child(uid).child("ComeIn")
//                        employeeCheck.updateChildValues(["Check":false,"PreviousDate":myStringafd], withCompletionBlock: { (err, ref) in
//                            if err != nil{
//                                print(err)
//                                return
//                            }
//                        })
                        
                        
                        print("Save user successfully into firebase DB")
                        
                        self.emailId.text = ""
                        self.password.text = ""
                        self.confirmpass.text = ""
                        self.userName.text = ""
                        
                       // self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                        
                        
                    }else{
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
                
            }
            
        }else{
            
            
            let alertController = UIAlertController(title: "Error", message: "Please enter the valid email id or password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}

