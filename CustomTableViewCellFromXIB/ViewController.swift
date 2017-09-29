//
//  ViewController.swift
//  CustomTableViewCellFromXIB
//
//  Created by LinuxPlus on 9/19/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,MyProtocol {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mySegmentControl: UISegmentedControl!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var searchController: UISearchBar!
    //var cData = [[String:[String]]]()

    let cellData = ["kashee","Rajendra","Mohan","Venky","Ankit"]
    var cellData2 = ["gandhi ji","barak ubama","steve jobs","sundar pichai","modi ji"]
    let images:[String:String] = ["gandhi ji":"gandhi","barak ubama":"barak ubama","steve jobs":"steve_jobs","sundar pichai":"sundar-pichai","modi ji":"modi"]
    var descriptns = ["Django is a high-level Python Web framework that encourages rapid development and clean, pragmatic design. Built by experienced developers, it takes care of much of the hassle of Web development, so you can focus on writing your app without needing to reinvent the wheel. It’s free and open source.","Built by experienced developers, it takes care of much of the hassle of Web development, so you can focus on writing your app without needing to reinvent the wheel. It’s free and open source.","Python’s standard library is very extensive, offering a wide range of facilities as indicated by the long table of contents listed below. The library contains built-in modules (written in C)","Swift is a fantastic way to write software, whether it’s for phones, desktops, servers, or anything else that runs code. It’s a safe.","JDK 7 is a superset of JRE 7, and contains everything that is in JRE 7, plus tools such as the compilers and debuggers necessary for developing applets and applications."]
    
   var searchActive : Bool = false
   var filteredData: [String]!
    var userN:String?
    var uid:String?
    
    var users = [User]()
    
    let ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
         fetchUser()
        
//        let ref = Database.database().reference()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let uid = user?.uid else{
                return
            }
            self.uid = uid
            let user = self.ref.child("Users").child(uid).child("name")
            user.observeSingleEvent(of: .value, with: { (DataSnapshot) in
                self.userN = DataSnapshot.value as? String
            })
        }
        
        

    
        filteredData = cellData2
        searchController.delegate = self
        mySegmentControl.setImage(textEmbededImage(image: UIImage(named:"graduate-cap")!, string: "UNIVERSITY BOARD", color: UIColor.black), forSegmentAt: 0)
        mySegmentControl.setImage(textEmbededImage(image: UIImage(named:"male-university-graduate-silhouette-with-the-cap")!, string: "STUDENT BOARD", color: UIColor.black), forSegmentAt: 1)
    // Added a shadow to button
        plusButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        plusButton.layer.shadowRadius = 10.0
        plusButton.layer.cornerRadius = 28
        plusButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        plusButton.layer.shadowOpacity = 1.0
        plusButton.layer.masksToBounds = false
        
        
        mySegmentControl.selectedSegmentIndex = 1
        if mySegmentControl.selectedSegmentIndex == 0{
            plusButton.isHidden = true
        }
        
        let button = UIButton.init(type: .custom)
        //button.addTarget(self, action:#selector(self), for: UIControlEvents.touchUpInside)
    // adding left image to barbutton item
        button.frame = CGRect.init(x: 0, y: 0, width: 35, height: 35) //CGRectMake(0, 0, 30, 30)
        let leftImageView = UIImageView(image: UIImage(named:"gandhi"))
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
        
        mySegmentControl.layer.cornerRadius = 12
        mySegmentControl.layer.borderColor = UIColor.red.cgColor
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mySegmentControl.selectedSegmentIndex == 0{
            let cell = Bundle.main.loadNibNamed("UniversityTableViewCell", owner: self, options: nil)?.first as! UniversityTableViewCell
            if indexPath.row < 5{
                cell.txtLabel.text = cellData[indexPath.row]
            }
            
            return cell
            
        }else{
            
            if indexPath.row == 0{
                let cell = Bundle.main.loadNibNamed("SponseredTableViewCell", owner: self, options: nil)?.first as! SponseredTableViewCell
               let user = users[indexPath.row]
                cell.nameLabel.text = user.name
                
                //cell.nameLabel.text = filteredData[indexPath.row]
//                cell.profilePic.image = UIImage(named:images[filteredData[indexPath.row]]!)
                
                if let profileImageUrl = user.profileImageUrl {
                    cell.profilePic.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
                    
                }
                cell.profilePic.layer.cornerRadius = 21
                cell.profilePic.layer.masksToBounds = true
                cell.commentButton.layer.cornerRadius = 0.5 * cell.commentButton.bounds.size.width
                cell.commentButton.clipsToBounds = true
                cell.sponseredButton.layer.cornerRadius = 3
                
                return cell
            }else{
            let cell = Bundle.main.loadNibNamed("StudentTableViewCell", owner: self, options: nil)?.first as! StudentTableViewCell
                let user = users[indexPath.row]
                cell.postNameLabel.text = user.name
            //cell.postNameLabel.text = filteredData[indexPath.row]
           // cell.profilePicImageView.image = UIImage(named:images[filteredData[indexPath.row]]!)
            
                if let profileImageUrl = user.profileImageUrl {
                    cell.profilePicImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
                }
                
            cell.profilePicImageView.layer.cornerRadius = 21
            cell.profilePicImageView.layer.masksToBounds = true
            cell.commentButton.layer.cornerRadius = 0.5 * cell.commentButton.bounds.size.width
            cell.commentButton.clipsToBounds = true
            return cell
            }
        
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if mySegmentControl.selectedSegmentIndex == 0{
            return 70
        }else if indexPath.row == 0{
            return 87
        }else{
            return 70
        }
    }
    
    @IBAction func switchCustomTableViewCell(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if mySegmentControl.selectedSegmentIndex == 1{
            let storyBoard = UIStoryboard(name:"Main",bundle:nil);
            let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "StudentBoardTableViewController") as! StudentBoardTableViewController
            vcOBJ.notice = filteredData[indexPath.row]
            vcOBJ.image = images[filteredData[indexPath.row]]
            vcOBJ.desc = descriptns[indexPath.row]
            vcOBJ.userN = self.userN
            vcOBJ.uid = self.uid
            navigationController?.pushViewController(vcOBJ, animated: true)
            
        }
    }
    
    func textEmbededImage(image: UIImage, string: String, color:UIColor, imageAlignment: Int = 0, segFont: UIFont? = nil) -> UIImage {
            let font = segFont ?? UIFont.systemFont(ofSize: 16.0)
            let expectedTextSize: CGSize = (string as NSString).size(attributes: [NSFontAttributeName: font])
            let width: CGFloat = expectedTextSize.width + image.size.width + 5.0
            let height: CGFloat = max(expectedTextSize.height, image.size.width)
            let size: CGSize = CGSize(width: width, height: height)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let context: CGContext = UIGraphicsGetCurrentContext()!
            context.setFillColor(color.cgColor)
            let fontTopPosition: CGFloat = (height - expectedTextSize.height) / 2.0
            let textOrigin: CGFloat = (imageAlignment == 0) ? image.size.width + 5 : 0
            let textPoint: CGPoint = CGPoint.init(x: textOrigin, y: fontTopPosition)
            string.draw(at: textPoint, withAttributes: [NSFontAttributeName: font])
            let flipVertical: CGAffineTransform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height)
            context.concatenate(flipVertical)
            let alignment: CGFloat =  (imageAlignment == 0) ? 0.0 : expectedTextSize.width + 5.0
            context.draw(image.cgImage!, in: CGRect.init(x: alignment, y: ((height - image.size.height) / 2.0), width: image.size.width, height: image.size.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    @IBAction func segmentActions(_ sender: Any) {
        if mySegmentControl.selectedSegmentIndex == 0{
            plusButton.isHidden = true
        }else{
            plusButton.isHidden = false
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? cellData2 : cellData2.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        print("filteredData=\(filteredData)")
        tableView.reloadData()
    }
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name:"Main",bundle:nil);
        let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "AddPostViewController") as! AddPostViewController
        vcOBJ.image = "gandhi"
        vcOBJ.myProtocol = self
        navigationController?.pushViewController(vcOBJ, animated: true)
    }
    
    func setResultOfBusinessLogic(valueSent: [String]){
        filteredData.append("gandhi ji")
        cellData2 = filteredData
        descriptns.append(valueSent[0])
        self.tableView.reloadData()
    }
    
    func fetchUser(){
        self.ref.child("Users").observe(.childAdded, with: {(DataSnapshot) in
            if let dictionary = DataSnapshot.value as? [String:AnyObject]{
                let user = User()
                user.setValuesForKeys(dictionary)
               // print(user.name,user.email)
                self.users.append(user)
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
               
            }
        })
    }
}

