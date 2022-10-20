//
//  ViewController.swift
//  fitnessApp
//
//  Created by Ryan Raitz on 10/15/19.
//  Copyright © 2019 Ryan Raitz. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
import AVKit
import WebKit

//View controller for exercises of a given day
class TableViewController: UITableViewController
{
    
    var feedItems: NSArray = NSArray()
    var currencyItems: Array = Array<String>()
    var selectedLocation : LocationModel?
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer:AVPlayer? = nil
    var finalDate: String = ""
    var currencyArray: [String] = []
    var dateArray = [String:Any]()
    var sortedDateArray = [String:Any]()
    
    @IBOutlet weak var todaysWorkoutLabel: UILabel!
    
    @IBOutlet weak var muscleGroupLabel: UILabel!
    
    @IBOutlet weak var exerciseLabel: UILabel!
    
    @IBOutlet weak var repsLabel: UILabel!
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBAction func buttonLogout(_ sender: UIButton)
    {
        
        //Removing values from default
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //Switching to login screen
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewcontroller") as! LoginViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        for item in dateArray
        {
            if(item.key == "userVideos")
            {
                sortedDateArray = item.value as! [String : Any]
                print(item.value)
                
            }
            
        }
        print("transferred array: \(dateArray)")
        print("sorted array: \(sortedDateArray)")
        
    }
    
    
    //Setting the size of the table view based on content size
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        return sortedDateArray.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var myCell: UITableViewCell
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            myCell = dequeueCell
        } else {
            myCell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        myCell.textLabel?.textColor = .black
        myCell.textLabel?.layer.shadowColor = UIColor.black.cgColor
        myCell.textLabel?.layer.shadowOffset = CGSize(width: 10, height: 10)
        myCell.textLabel?.layer.shadowRadius = 10
        myCell.textLabel?.layer.shadowOpacity = 1.5
        
        myCell.backgroundColor = .systemGreen
        
        let name = Array(sortedDateArray)[indexPath.row].value as? String
        
        myCell.textLabel?.text = name
        
        return myCell
    }
    
    
    //Function to pass data to the TestViewController whenever a cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        let name = cell?.textLabel?.text
        let email = dateArray["userEmail"] as! String
        
        let urlRef = Storage.storage().reference(forURL: "gs://golfapp-fe22e.appspot.com/videoDownloads/\(email)/\(name!)done.mov")
        
        
        urlRef.downloadURL { url, error in
            if error != nil
            {
                print("error")
                // Handle any errors
            }
            else
            {
                // Get the download URL for 'images/stars.jpg'
                print(url!)
                if url != nil
                {
                    self.avPlayer = AVPlayer(url: url!)
                    self.avPlayerViewController.player = self.avPlayer
                    print("downloadUrl obtained and set")
                }
            }
        }

        self.present(self.avPlayerViewController, animated: true) { () -> Void in
            self.avPlayerViewController.player?.play()
        }
        
    }
    
    //Function to perform segue to the TestViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        
    }
    
    
}

