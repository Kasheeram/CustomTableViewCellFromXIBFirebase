//
//  LoginViewController.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/28/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginButtonTapped(_ sender: Any) {
//        let storyBoard = UIStoryboard(name:"Main",bundle:nil)
//        let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "Navigation")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = vcOBJ
        
        
        if (emailId.text?.characters.count)! > 0 && (password.text?.characters.count)! > 0{
            
            Auth.auth().signIn(withEmail: emailId.text!, password: password.text!) { (user, error) in
                
                if error == nil {
                    // Toast(text: "You have successfully logged in").show()
                    let storyBoard = UIStoryboard(name:"Main",bundle:nil)
                    let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "Navigation")
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = vcOBJ
                    
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
        }else{
            
            let alertController = UIAlertController(title: "Error", message: "Please don't enter null value", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }

        
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name:"Main",bundle:nil)
        let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        //navigationController?.pushViewController(vcOBJ, animated: true)
        self.present(vcOBJ, animated: true, completion: nil)
        
        
        
    }
}
