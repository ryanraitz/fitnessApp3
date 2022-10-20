//
//  RegisterViewController.swift
//  fitnessApp
//
//  Created by Ryan Raitz on 10/25/19.
//  Copyright © 2019 Ryan Raitz. All rights reserved.
//

import Alamofire
import UIKit
import Firebase
import FirebaseDatabase

//View controller for sign up screen
class RegisterViewController: UIViewController {
    
    let defaultValues = UserDefaults.standard
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var textFieldUsername: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    //Sign up button action
    @IBAction func buttonRegister(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: textFieldUsername.text!, password: textFieldPassword.text!)
        { (user, error) in
            if error == nil
            {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                
                changeRequest?.displayName = self.textFieldName.text!
                changeRequest?.commitChanges { (error) in
                    // ...
                }
                let fullName = self.textFieldName.text!
                let firstName = fullName.components(separatedBy: " ")[0]
                let email = self.textFieldUsername.text!
                let credits = 1
                let count = 1
                let videos = ""
                let avideos = "1"
                let subID = "2"
                guard let userID = Auth.auth().currentUser?.uid else { return }
                guard let userEmail = Auth.auth().currentUser?.email else { return }
//                self.defaultValues.set(true, forKey: "usersignedin")
//                self.defaultValues.set(self.textFieldUsername.text!, forKey: "userEmail")
//                self.defaultValues.set(fullName, forKey: "userName")
//                self.defaultValues.set(firstName, forKey: "userFirstName")
//
//                self.defaultValues.synchronize()
                let location = LocationModel()
                location.userID = userID
                location.userName = fullName
                location.userFirstName = firstName
                location.userEmail = email
                location.userCredits = credits
                location.userVideos = [:]
                location.userCreditsString = avideos
                location.userSubscriptionID = ""
                location.userVideoCount = count
                
//                let userProfile:[String : Any] = [
//                    "userID":userID,
//                    "userName":fullName,
//                    "userFirstName":firstName,
//                    "userEmail":email,
//                    "userCredits":credits,
//                    "userVideos":videos,
//                    "userCreditsString":avideos,
//                    "userSubscriptionID":subID
//                ]
                
                let ref = Database.database().reference()
                //let autoID = ref.child("golfAppData").childByAutoId()
                //print(autoID.key!)
                let finalRef = ref.child("golfAppData").child(userID)
                
                let userProfile:[String : Any] = [
                    "userID":userID,
                    "userName":fullName,
                    "userFirstName":firstName,
                    "userEmail":email,
                    "userCredits":credits,
                    "userVideos":videos,
                    "userCreditsString":avideos,
                    "userSubscriptionID":subID,
                    "userVideoCount": count
                ]
                
                finalRef.setValue(userProfile)
                //autoID.setValue(userProfile)
                //ref.child("golfAppData").childByAutoId().setValue(userProfile)
                //      ref.setValue(userInfoDictionary) { (error:Error?, ref:DatabaseReference) in

//                ref.setValue(location, withCompletionBlock: { err, ref in
//                    if let error = err {
//                        print("User profile was not saved: \(error.localizedDescription)")
//                    } else {
//                        print("User profile saved successfully!")
//                    }
//                })
                
                print(location.description)
                
                
                let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "WeekViewcontroller") as! WeekViewController
                //tempViewController.title = "Welcome"
                self.navigationController?.pushViewController(tempViewController, animated: true)
                
                self.dismiss(animated: false, completion: nil)
                
            }
            else
            {
                //Check to see if there is an account under the given email
                Auth.auth().fetchSignInMethods(forEmail: self.textFieldUsername.text!, completion: { (stringArray, error) in
                    if error != nil
                    {
                        self.labelMessage.text = "Error: " + error!.localizedDescription
                    }
                    else
                    {
                        if stringArray == nil
                        {
                            
                            self.labelMessage.text = "Error: Invalid data entry"
                        }
                        else
                        {
                            //error message if existing user tries to sign up
                            self.labelMessage.text = "Error: User already exists under given email address"
                        }
                    }
                })
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Title label styling
        labelTitle.layer.shadowColor = UIColor.black.cgColor
        labelTitle.layer.shadowOffset = CGSize(width: 10, height: 10)
        labelTitle.layer.shadowRadius = 10
        labelTitle.layer.shadowOpacity = 1.0
        
        //Navigation bar styling
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemTeal]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.systemTeal
        self.navigationController?.view.backgroundColor = .clear
        
        //Email text field styling
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0, y: textFieldUsername.frame.height-2, width: textFieldUsername.frame.width, height: 2)
        bottomLine1.backgroundColor = UIColor.white.cgColor
        textFieldUsername.borderStyle = .none
        textFieldUsername.layer.addSublayer(bottomLine1)
        textFieldPassword.backgroundColor = .clear
        self.textFieldUsername.attributedPlaceholder = NSAttributedString(string: "Enter Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        //Password text field styling
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0, y: textFieldPassword.frame.height-2, width: textFieldPassword.frame.width, height: 2)
        bottomLine2.backgroundColor = UIColor.white.cgColor
        textFieldPassword.borderStyle = .none
        textFieldPassword.layer.addSublayer(bottomLine2)
        textFieldPassword.backgroundColor = .clear
        self.textFieldPassword.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        //Name text field styling
        let bottomLine4 = CALayer()
        bottomLine4.frame = CGRect(x: 0, y: textFieldName.frame.height-2, width: textFieldName.frame.width, height: 2)
        bottomLine4.backgroundColor = UIColor.white.cgColor
        textFieldName.borderStyle = .none
        textFieldName.layer.addSublayer(bottomLine4)
        textFieldPassword.backgroundColor = .clear
        self.textFieldName.attributedPlaceholder = NSAttributedString(string: "Enter First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        // Sign up button styling
        /* registerButton.layer.cornerRadius = 5
         registerButton.layer.shadowColor = UIColor.black.cgColor
         registerButton.layer.shadowOffset = CGSize(width: 5, height: 5)
         registerButton.layer.shadowRadius = 10
         registerButton.layer.shadowOpacity = 1.0
         */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
