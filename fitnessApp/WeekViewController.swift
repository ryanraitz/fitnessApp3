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

//View controller for weekly workouts screen
class WeekViewController: UIViewController {

    let ref = Database.database().reference(withPath: "maleExercises")
    
    @IBOutlet weak var logoutButtonStyle: UIBarButtonItem!
    
    
    @IBOutlet weak var greetingButton: UIButton!
    
    
    @IBOutlet weak var sundayButtonStyle: UIButton!
    
    
    @IBOutlet weak var sundayButtonStyle2: UIButton!
    
    
    @IBOutlet weak var mondayButtonStyle: UIButton!
    
    
    @IBOutlet weak var tuesdayButtonStyle: UIButton!
    
    
    @IBOutlet weak var wednesdayButtonStyle: UIButton!
    
    
    @IBOutlet weak var thursdayButtonStyle: UIButton!
    
    
    @IBOutlet weak var fridayButtonStyle: UIButton!
    
    
    @IBOutlet weak var saturdayButtonStyle: UIButton!
    
    
    @IBOutlet weak var saturdayButtonStyle2: UIButton!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
               UserDefaults.standard.synchronize()
               
               //switching to login screen
               let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewcontroller") as! LoginViewController
               self.navigationController?.pushViewController(loginViewController, animated: true)
               self.dismiss(animated: false, completion: nil)
        
    }
    
    
    @IBAction func sundayButton(_ sender: Any) {
        
        
        let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "Viewcontroller") as! ViewController
        tempViewController.title = "Sunday"
        tempViewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemTeal]
        self.navigationController?.pushViewController(tempViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func sundayButton2(_ sender: Any) {
        
        let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "Viewcontroller") as! ViewController
        tempViewController.title = "Sunday"
        tempViewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemTeal]
        self.navigationController?.pushViewController(tempViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    @IBAction func mondayButton(_ sender: Any) {
        
        let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "Viewcontroller") as! ViewController
        tempViewController.title = "Monday"
        self.navigationController?.pushViewController(tempViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func tuesdayButton(_ sender: Any) {
        
        let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "Viewcontroller") as! ViewController
        tempViewController.title = "Tuesday"
        self.navigationController?.pushViewController(tempViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    @IBAction func wednesdayButton(_ sender: Any) {
        
        let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "Viewcontroller") as! ViewController
        tempViewController.title = "Wednesday"
        self.navigationController?.pushViewController(tempViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    @IBAction func thursdayButton(_ sender: Any) {
        
        let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "Viewcontroller") as! ViewController
        tempViewController.title = "Thursday"
        self.navigationController?.pushViewController(tempViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func fridayButton(_ sender: Any) {
        
        let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "Viewcontroller") as! ViewController
        tempViewController.title = "Friday"
        self.navigationController?.pushViewController(tempViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func saturdayButton(_ sender: Any) {
        
        let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "Viewcontroller") as! ViewController
        tempViewController.title = "Saturday"
        self.navigationController?.pushViewController(tempViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    @IBAction func saturdayButton2(_ sender: Any) {
        
        let tempViewController = self.storyboard?.instantiateViewController(withIdentifier: "Viewcontroller") as! ViewController
        tempViewController.title = "Saturday"
        self.navigationController?.pushViewController(tempViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 10)
        titleLabel.layer.shadowRadius = 10
        titleLabel.layer.shadowOpacity = 1.0
        
        
        sundayButtonStyle.layer.cornerRadius = 10
        //sundayButtonStyle.layer.shadowColor = UIColor.black.cgColor
        //sundayButtonStyle.layer.shadowOffset = CGSize(width: -10, height: -10)
        //sundayButtonStyle.layer.shadowRadius = 10
        //sundayButtonStyle.layer.shadowOpacity = 1.0
        sundayButtonStyle.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 7));
        
        
        mondayButtonStyle.layer.cornerRadius = 10
        mondayButtonStyle.layer.shadowColor = UIColor.black.cgColor
        mondayButtonStyle.layer.shadowOffset = CGSize(width: 10, height: -10)
        mondayButtonStyle.layer.shadowRadius = 10
        mondayButtonStyle.layer.shadowOpacity = 1.0
        mondayButtonStyle.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 7));
        
        tuesdayButtonStyle.layer.cornerRadius = 10
        tuesdayButtonStyle.layer.shadowColor = UIColor.black.cgColor
        tuesdayButtonStyle.layer.shadowOffset = CGSize(width: -10, height: -10)
        tuesdayButtonStyle.layer.shadowRadius = 10
        tuesdayButtonStyle.layer.shadowOpacity = 1.0
        tuesdayButtonStyle.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 7));
        
        wednesdayButtonStyle.layer.cornerRadius = 10
        wednesdayButtonStyle.layer.shadowColor = UIColor.black.cgColor
        wednesdayButtonStyle.layer.shadowOffset = CGSize(width: 10, height: -10)
        wednesdayButtonStyle.layer.shadowRadius = 10
        wednesdayButtonStyle.layer.shadowOpacity = 1.0
        wednesdayButtonStyle.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 7));
        
        thursdayButtonStyle.layer.cornerRadius = 10
        thursdayButtonStyle.layer.shadowColor = UIColor.black.cgColor
        thursdayButtonStyle.layer.shadowOffset = CGSize(width: -10, height: -10)
        thursdayButtonStyle.layer.shadowRadius = 10
        thursdayButtonStyle.layer.shadowOpacity = 1.0
        thursdayButtonStyle.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 7));
        
        fridayButtonStyle.layer.cornerRadius = 10
        fridayButtonStyle.layer.shadowColor = UIColor.black.cgColor
        fridayButtonStyle.layer.shadowOffset = CGSize(width: -10, height: -10)
        fridayButtonStyle.layer.shadowRadius = 10
        fridayButtonStyle.layer.shadowOpacity = 1.0
        fridayButtonStyle.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 7));
        
        saturdayButtonStyle.layer.cornerRadius = 10
        saturdayButtonStyle.layer.shadowColor = UIColor.black.cgColor
        saturdayButtonStyle.layer.shadowOffset = CGSize(width: 10, height: -10)
        saturdayButtonStyle.layer.shadowRadius = 10
        saturdayButtonStyle.layer.shadowOpacity = 1.0
        saturdayButtonStyle.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 7));
        saturdayButtonStyle2.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 7));
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        
        if let name = Auth.auth().currentUser?.displayName
        {
            //setting the name to label
            let backButton = UIBarButtonItem(title: "Hey " + name + "!", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
            
             
            navigationItem.leftBarButtonItem = backButton
            //navBar.title = "Hello " + name + "!"
        }
        else
        {
            let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
            navigationItem.leftBarButtonItem = backButton
        }
    }
}
