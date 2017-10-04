//
//  StudentBoardTableViewController.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/21/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit
import Firebase

class StudentBoardTableViewController: UITableViewController,UITextFieldDelegate {
    
    let noteCell:ProfileDetailsTableViewCell! = nil
    var notice:String?
    var image:String?
    var desc:String?
    var name:String?
    var userN:String?
    var uid:String?
    var date:String?
    var postID:String?
    
    var commentsData = [Comments]()
    let ref = Database.database().reference()
    let userID : String = (Auth.auth().currentUser?.uid)!
    let currentuser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("Users").child(userID).observeSingleEvent(of: .value, with: {(DataSnapshot) in
            if let dictionary = DataSnapshot.value as? [String:AnyObject]{
                self.currentuser.setValuesForKeys(dictionary)
            }
        })
        
        fetchComments()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let button = UIButton.init(type: .custom)
       // button.setImage(UIImage.init(named: image!), for: UIControlState.normal)
        button.addTarget(self, action:#selector(StudentBoardTableViewController().profilePicClicked), for: UIControlEvents.touchUpInside)
    // adding left image to barbutton item
        button.frame = CGRect.init(x: 0, y: 0, width: 35, height: 35) //CGRectMake(0, 0, 30, 30)
        let leftImageView = UIImageView()
        if let profileImageUrl = image {
            leftImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
             return 1
        }else{
            return commentsData.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = Bundle.main.loadNibNamed("ProfileDetailsTableViewCell", owner: self, options: nil)?.first as! ProfileDetailsTableViewCell
            
            var bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0.0, y: cell.inputText.frame.height - 1, width: cell.inputText.frame.width+50, height: 0.5)
            bottomLine.backgroundColor = UIColor.lightGray.cgColor
            cell.inputText.borderStyle = UITextBorderStyle.none
            cell.inputText.layer.addSublayer(bottomLine)
            cell.nameLabel.text = notice
            cell.detailsLabel.text = desc
            cell.postedByLabel.text = userN
            cell.dateLabel.text = date
            if let profileImageUrl = currentuser.profileImageUrl {
                cell.profilePicofCommentedUser.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
            }
            cell.numberOfCommentLabel.text = "(\(commentsData.count))"
            cell.inputText.delegate = self
            cell.profilePicofCommentedUser.layer.cornerRadius = 17
            cell.profilePicofCommentedUser.layer.masksToBounds = true
            
            //cell.addButton.addTarget(StudentBoardTableViewController(),action:#selector(addComments(sender:)), for: .touchUpInside)
            tableView.estimatedRowHeight = 280
            tableView.rowHeight = UITableViewAutomaticDimension
            return cell
            
        }else{
            
            let cell = Bundle.main.loadNibNamed("CommentsTableViewCell", owner: self, options: nil)?.first as! CommentsTableViewCell
            let cmt = commentsData[indexPath.row]
            cell.commentLabe.text = cmt.text
            
            if let profileImageUrl = cmt.image {
                cell.userImage.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
            }
            
            cell.userImage.layer.cornerRadius = 17
            cell.userImage.layer.masksToBounds = true
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableViewAutomaticDimension
            return cell
        }
    }
    
    func addComments() {
        let ndx = IndexPath(row: 0, section: 0)
        let cell = self.tableView.cellForRow(at:ndx) as! ProfileDetailsTableViewCell
        let txt = cell.inputText.text!
       
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: Date())
        let message = ref.child("Comments").child(postID!).childByAutoId()
        
        let values = ["name":self.currentuser.name,"uid":userID,"image":currentuser.profileImageUrl,"date":dateString,"text":txt]
        message.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil{
                print(err)
                return
            }
            self.tableView.reloadData()
        })
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            tableView.rowHeight = UITableViewAutomaticDimension
            return tableView.rowHeight
        }else{
           var resStr = commentsData[indexPath.row].text
            if (resStr?.characters.count)! > 38{
                tableView.rowHeight = UITableViewAutomaticDimension
                return tableView.rowHeight
            }else{
               return 50
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name:"Main",bundle:nil);
        let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
        vcOBJ.title = "User Information"
        vcOBJ.uid = commentsData[indexPath.row].uid
       // navigationController?.pushViewController(vcOBJ, animated: true)
        present(vcOBJ, animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addComments()
        return true
    }
    func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func fetchComments() {
            self.ref.child("Comments").child(self.postID!).observe(.childAdded, with: {(DataSnapshot) in
                if let dictionary = DataSnapshot.value as? [String:AnyObject]{
                    let user = Comments()
                    user.setValuesForKeys(dictionary)
                    print("123\(user.text)")
                    self.commentsData.append(user)
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                    
                }
            })
    }
    
    func profilePicClicked(){
        let storyBoard = UIStoryboard(name:"Main",bundle:nil);
        let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        //vcOBJ.title = "User Information"
       // vcOBJ.uid = commentsData[indexPath.row].uid
        // navigationController?.pushViewController(vcOBJ, animated: true)
        present(vcOBJ, animated: true, completion: nil)
    }
    
}
