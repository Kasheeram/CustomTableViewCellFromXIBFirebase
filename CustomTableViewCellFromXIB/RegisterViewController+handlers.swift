//
//  RegisterViewController+handlers.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/29/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit
import Firebase

extension RegisterViewController {
    
    // Register function
    
    func regiseterHandler(name:String,email:String,college:String,branch:String,phone:String){
        
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
                        
                        let imageName = NSUUID().uuidString
                        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
                        if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!){
                           storageRef.putData(uploadData, metadata: nil, completion: {(metadata, error) in
                            if error != nil{
                                print(error)
                                return
                            }
                            if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                                let values = ["name":name,"email":email,"profileImageUrl":profileImageUrl,"college":college,"branch":branch,"phone":phone] as [String : Any]
                                
                                self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                            }
                           })
                        }
                        print("Save user successfully into firebase DB")
                        self.emailId.text = ""
                        self.password.text = ""
                        self.confirmpass.text = ""
                        self.userName.text = ""
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
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    
    }
    
    private func registerUserIntoDatabaseWithUID(uid:String,values:[String:AnyObject]){
        let ref = Database.database().reference(fromURL: "https://basicspace-63da9.firebaseio.com/")
        let users = ref.child("Users").child(uid)
        // let message = ref.child("Messages")
        
        users.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil{
                print(err)
                return
            }
        })
    }
    
    func handleSelectProfileImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel picker")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker{
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}
