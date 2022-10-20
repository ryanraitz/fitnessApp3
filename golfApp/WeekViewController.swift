//
//  WeekViewController.swift
//  fitnessApp
//
//  Created by Ryan Raitz on 10/29/19.
//  Copyright © 2019 Ryan Raitz. All rights reserved.
//
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseStorage
import MessageUI

//View controller for weekly workouts screen
class WeekViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    
    let ref = Database.database().reference()
    
    let storageRef = Storage.storage()
    
    let imagePickerController = UIImagePickerController()
    
    var dictOne = [String:Any]()
    //var videoURL: NSURL?
    //var videoPicker : VideoPicker?
    
    @IBOutlet weak var logoutButtonStyle: UIBarButtonItem!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var newSwingReview: UIButton!
    
    @IBOutlet weak var swingReviewLibrary: UIButton!
    
    var selectedLocation : LocationModel?
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //switching to login screen
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewcontroller") as! LoginViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    @IBAction func swingLibrarySelected(_ sender: Any) {
        
        //let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "Viewcontroller") as! ViewController
        let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "tableviewcontroller") as! TableViewController
        tempViewController.dateArray = dictOne
        tempViewController.title = "Reviewed Videos"
        self.navigationController?.pushViewController(tempViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    
    @IBAction func newReviewSelected(_ sender: Any) {
        
        self.imagePickerController.sourceType = .photoLibrary
        self.imagePickerController.delegate = self
        self.imagePickerController.mediaTypes = ["public.image", "public.movie"]
        // Create a new alert
        let dialogMessage = UIAlertController(title: "Oops!", message: "You need more credits before submitting another video", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        
        if self.dictOne["userCredits"] as! Int >= 1
        {
            self.present(self.imagePickerController, animated: true, completion: nil)
        
            print("selected")
        }
        else
        {
            // Present alert to user
            self.present(dialogMessage, animated: true, completion: nil)
            print("not enough credits")
        }
        
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 10)
        titleLabel.layer.shadowRadius = 10
        titleLabel.layer.shadowOpacity = 1.0
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        //print(printCredits)
        let postRef = ref.child("golfAppData")
        postRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                for child in snapshot.children {
                    // Get user value
                    let snap = child as! DataSnapshot
                    let dict = snap.value as! [String: Any]
                    
                    let userCreditsString = dict["userCreditsString"] as! String
                    
                    let backButton = UIBarButtonItem(title: "Credits: " + userCreditsString + "", style: UIBarButtonItem.Style.plain, target: self.navigationController, action: nil)
                    
                    self.navigationItem.leftBarButtonItem = backButton
                    
                    // ...
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        // Initialize cell text labels to desired info
        let postRef = ref.child("golfAppData")
        postRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                for child in snapshot.children {
                    // Get user value
                    let snap = child as! DataSnapshot
                    let tempDict = snap.value as! [String: Any]
                    if tempDict["userID"] as! String == Auth.auth().currentUser?.uid as! String
                    {
                        self.dictOne = snap.value as! [String: Any]
                        let userCreditsString = self.dictOne["userCreditsString"] as! String
                        
                        let backButton = UIBarButtonItem(title: "Credits: " + userCreditsString + "", style: UIBarButtonItem.Style.plain, target: self.navigationController, action: nil)
                        
                        self.navigationItem.leftBarButtonItem = backButton
                        //self.dictOne = [:]
                        //self.dictOne = dict
                        print("correct:\(tempDict)")
                    }
                    else
                    {
                        print("wrong person")
                        //self.dictOne = [:]
                    }
                    // ...
                }
            }
        }
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        self.dismiss(animated: true, completion: nil)
        
        guard let videoURLTwo = info[.mediaURL] as? NSURL else {return }
        let videoUrlTwo = videoURLTwo.filePathURL as NSURL?
        let user = (Auth.auth().currentUser?.uid)!
        let userEmail = (Auth.auth().currentUser?.email)!
        let date = self.getDate()
        let date2 = "14-10-2022"
        let storageReference = storageRef.reference().child("videoUploads/\(userEmail)/\(date).mov")
        //let storageReference2 = storageRef.reference().child("videoDownloads/\(userEmail)/image.mov")
        
        let uploadTask = storageReference.putFile(from: videoUrlTwo! as URL, metadata: nil) { metadata, error in
            guard metadata != nil
                else {
                    // Uh-oh, an error occurred!
                    print("error")
                    return
            }
            
            let postRef = self.ref.child("golfAppData")
            postRef.observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.exists() {
                    for child in snapshot.children {
                        // Get user value
                        let snap = child as! DataSnapshot
                        let dict = snap.value as! [String: Any]
                        
                        if dict["userID"] as! String == user
                        {
                            
                            let userCredits = dict["userCredits"] as! Int
                            let userCreditsString = dict["userCreditsString"] as! String
                            let userVideoCount = dict["userVideoCount"] as! Int
                            //let dict = self.selectedLocation?.userVideos
                            //let dictLength = dict.value(forKey: "userVideos") as? [String: Any]
                            //print(dict)
                            
                            let updatedUserCredits = userCredits - 1
                            var updatedUserCreditsString = String(updatedUserCredits)
                            print("User credits were:\(userCreditsString)")
                            print("User credits are:\(updatedUserCredits)")
                            print("User credits as string are:\(updatedUserCreditsString)")
                            
                            //let videoValues = ["videoDate": date2]
                            
                            let utentiRef = postRef.child("\(user)").child("userVideos")
                            let refToAdd = utentiRef.child("videoDate\(userVideoCount)")//or whatever the key name is; .child("xyz")
                            refToAdd.setValue(date)
                            
                            let updatedUserVideoCount = userVideoCount + 1
                            
                            postRef.child("\(user)").updateChildValues(["userCredits": updatedUserCredits, "userCreditsString": updatedUserCreditsString, "userVideoCount": updatedUserVideoCount])
                            
                            print("Credits/Video dates updated")
                        }
                        
                    }
                }
            }
        }
    }
    
    func getDate() -> String
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let myString = dateFormatter.string(from: date)
        //print(myString!)
        return myString
    }
}
