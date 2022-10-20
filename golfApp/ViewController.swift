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
class ViewController: UITableViewController, HomeModelProtocol, SaturdayProtocol  {
    
    //Properties
    //UITableViewDataSource, UITableViewDelegate
    var feedItems: NSArray = NSArray()
    var currencyItems: Array = Array<String>()
    var selectedLocation : LocationModel = LocationModel()
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer:AVPlayer? = nil
    var finalDate: String = ""
    var names: [String] = ["14-10-2022", "13-10-2022", "12-10-2022"]
    
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
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //self.currencyItems = self.getDates() as NSArray
        //Workout label styling
        todaysWorkoutLabel.layer.shadowColor = UIColor.black.cgColor
        todaysWorkoutLabel.layer.shadowOffset = CGSize(width: 10, height: 10)
        todaysWorkoutLabel.layer.shadowRadius = 10
        todaysWorkoutLabel.layer.shadowOpacity = 1.0
        
        //Excercise label styling
        exerciseLabel.layer.shadowColor = UIColor.black.cgColor
        exerciseLabel.layer.shadowOffset = CGSize(width: 10, height: 10)
        exerciseLabel.layer.shadowRadius = 10
        exerciseLabel.layer.shadowOpacity = 1.0
        
        //Reps label styling
        repsLabel.layer.shadowColor = UIColor.black.cgColor
        repsLabel.layer.shadowOffset = CGSize(width: 10, height: 10)
        repsLabel.layer.shadowRadius = 10
        repsLabel.layer.shadowOpacity = 1.0
        
        //set delegates and initialize homeModel based on the day
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        /*Initializing protocol based on which day of the week button was pressed
        if(self.title == "Sunday")
        {
            let homeModel = SundayModel()
            homeModel.delegate = self
            homeModel.downloadFirItems()
        }
        if(self.title == "Monday")
        {
            let homeModel = MondayModel()
            homeModel.delegate = self
            homeModel.downloadFirItems()
        }
        if(self.title == "Tuesday")
        {
            let homeModel = TuesdayModel()
            homeModel.delegate = self
            homeModel.downloadFirItems()
        }
        if(self.title == "Wednesday")
        {
            let homeModel = WednesdayModel()
            homeModel.delegate = self
            homeModel.downloadFirItems()
        }
        if(self.title == "Thursday")
        {
            let homeModel = ThursdayModel()
            homeModel.delegate = self
            homeModel.downloadFirItems()
        }
        if(self.title == "Friday")
        {
            let homeModel = FridayModel()
            homeModel.delegate = self
            homeModel.downloadFirItems()
        }
        if(self.title == "Saturday")
        {
            let homeModel = SaturdayModel()
            homeModel.delegate = self
            homeModel.downloadFirItems()
        }
        */
        let homeModel = SaturdayModel()
        homeModel.delegate = self
        homeModel.downloadFirItems()
        //Table view styling
        listTableView.backgroundColor = .clear
        listTableView.layer.backgroundColor = UIColor.clear.cgColor
        
        //Navigation bar styling
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
         //Create a reference to the file you want to download
//        let userEmail = (Auth.auth().currentUser?.email)!
//        //var finalDate: String
//        //print(finalDate)
//        
//        
//        let urlRef = Storage.storage().reference(forURL: "gs://golfapp-fe22e.appspot.com/videoUploads/ultimateaccessfn@gmail.com/12-10-2022.mov")
//
//        urlRef.downloadURL { url, error in
//            if error != nil
//            {
//            // Handle any errors
//            }
//            else
//            {
//            // Get the download URL for 'images/stars.jpg'
//                print(url!)
//                if url != nil
//                {
//                    self.avPlayer = AVPlayer(url: url!)
//                    self.avPlayerViewController.player = self.avPlayer
//                    print("downloadUrl obtained and set")
//                }
//          }
//        }

        
    }
    
    //Getting data from protocol
    func itemsDownloaded(items: NSArray)
    {
        
        //currencyItems = items as! [String]
        feedItems = items
        //print(feedItems)
        self.listTableView.reloadData()
    }
    
    //Setting the size of the table view based on content size
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        //Return the number of feed items
        //currencyItems = self.getDates()
        //let item: LocationModel = feedItems[0] as! LocationModel
        //let count = item.userVideoCount!
        
        print(names.count)
        return names.count
        
        
    }
    
    func getDates() -> [String]
    {
        let item: LocationModel = feedItems[0] as! LocationModel
        //var currencyArray: [String] = []
        var currencyArray: [String] = []
        for (k,v) in item.userVideos!
        {
            if(k != "")
            {
                print(v)
                currencyArray.append(v as! String)
                //return v as! String
            }
            
        }
//        if(item.userVideos == "1" && item.goalID == "2" || item.goalID == "4")
//        {
//            return "Shoulders (Hypertrophy)"
//        }
//        if(item.userVideos == "2" && item.goalID == "1" || item.goalID == "3")
//        {
//            return "Legs (Strength)"
//        }
//        if(item.userVideos == "2" && item.goalID == "2" || item.goalID == "4")
//        {
//            return "Legs (Hypertrophy)"
//        }
//        if(item.userVideos == "3" && item.goalID == "1" || item.goalID == "3")
//        {
//            return "Back (Strength)"
//        }
//        if(item.userVideos == "3" && item.goalID == "2" || item.goalID == "4")
//        {
//            return "Back (Hypertrophy)"
//        }
//        if(item.userVideos == "4" && item.goalID == "1" || item.goalID == "3")
//        {
//            return "Arms (Strength)"
//        }
//        if(item.userVideos == "4" && item.goalID == "2" || item.goalID == "4")
//        {
//            return "Arms (Hypertrophy)"
//        }
//        if(item.userVideos == "5" && item.goalID == "1" || item.goalID == "3")
//        {
//            return "Chest (Strength)"
//        }
//        if(item.userVideos == "5" && item.goalID == "2" || item.goalID == "4")
//        {
//            return "Chest (Hypertrophy)"
//        }
//        if(item.userVideos == "6")
//        {
//            return "Abs"
//        }
//        if(item.userVideos == "7")
//        {
//            return "Calisthenics"
//        }
//        else { return "aint"}
//        }
        //self.currencyItems = currencyArray as NSArray
        print(currencyItems)
        currencyItems = currencyArray
        return currencyArray
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
//        //Retrieve cell
//        let cellIdentifier: String = "BasicCell"
//        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
//        //print(currencyItems)
//        //let array = getDates()
//        //print(array)
//        //let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
//        //print(self.currencyItems)
//        //let currentKey = array[indexPath.row]
//        //Get the location to be shown
//        let item: LocationModel = feedItems[indexPath.row] as! LocationModel
//        print(item)
//
//        //Cell label styling
//        myCell.textLabel?.textColor = .black
//        myCell.textLabel?.layer.shadowColor = UIColor.black.cgColor
//        myCell.textLabel?.layer.shadowOffset = CGSize(width: 10, height: 10)
//        myCell.textLabel?.layer.shadowRadius = 10
//        myCell.textLabel?.layer.shadowOpacity = 1.5
//        myCell.detailTextLabel?.textColor = .black
//        myCell.detailTextLabel?.layer.shadowColor = UIColor.black.cgColor
//        myCell.detailTextLabel?.layer.shadowOffset = CGSize(width: 10, height: 10)
//        myCell.detailTextLabel?.layer.shadowRadius = 10
//        myCell.detailTextLabel?.layer.shadowOpacity = 1.5
//
//        myCell.textLabel?.text =  item.userVideos?["videoDate1"] as? String
//        myCell.detailTextLabel!.text = ""
//
//        //Cell styling
//        myCell.layer.backgroundColor = UIColor.clear.cgColor
//        myCell.backgroundColor = .clear
//
//        //Set muscle group label
//        //muscleGroupLabel.text =
//
//        return myCell
        //Retrieve cell
        let cellIdentifier: String = "BasicCell"
        //var urlRef: StorageReference
        //let starsRef = Storage.storage().reference()
        //let muscleGroup : String = getWorkoutTitle()
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!

        //Get the location to be shown
        let item: LocationModel = feedItems[indexPath.row] as! LocationModel

        //Cell label styling
        //let videoDate = item.userVideos?["videoDate"] as! String
        //print(videoDate)
        myCell.textLabel?.textColor = .black
        myCell.textLabel?.layer.shadowColor = UIColor.black.cgColor
        myCell.textLabel?.layer.shadowOffset = CGSize(width: 10, height: 10)
        myCell.textLabel?.layer.shadowRadius = 10
        myCell.textLabel?.layer.shadowOpacity = 1.5
        myCell.detailTextLabel?.textColor = .black
        myCell.detailTextLabel?.layer.shadowColor = UIColor.black.cgColor
        myCell.detailTextLabel?.layer.shadowOffset = CGSize(width: 10, height: 10)
        myCell.detailTextLabel?.layer.shadowRadius = 10
        myCell.detailTextLabel?.layer.shadowOpacity = 1.5
        //myCell.textLabel!.text = item.userFirstName
        myCell.detailTextLabel!.text = ""
        var count = item.userVideoCount!
        count = count - 1
       
        var currencyArray: [String] = []
        //var keysArray = Array(item.userVideos!.keys)
        for (k,v) in item.userVideos!
        {
            currencyArray.append(v as! String)
        }
        print("Date array:\(currencyArray)")

//        if let date = item.userVideos?["videoDate\(count)"] as? String
//        {
//            //myCell.textLabel!.text = item.userVideos?[indexPath.row]
//            //myCell.textLabel!.text = date
//            finalDate = date
//            count = count + 1
//        }
//        else
//        {
//            myCell.textLabel!.text = ""
//        }
          
        print("Final Date:\(finalDate)")


        let urlRef = Storage.storage().reference(forURL: "gs://golfapp-fe22e.appspot.com/videoUploads/\(item.userEmail!)/\(finalDate).mov")


        urlRef.downloadURL { url, error in
            if error != nil
            {
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
        //myCell.textLabel!.text = currencyArray[indexPath.row]
        let name = names[indexPath.row]
        myCell.textLabel?.text = name

        //Cell styling
        myCell.layer.backgroundColor = UIColor.clear.cgColor
        myCell.backgroundColor = .clear

        //Set muscle group label
        //muscleGroupLabel.text = muscleGroup

        return myCell
    }
    
    //Function to pass data to the TestViewController whenever a cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        //Set selected location to var
        //selectedLocation = feedItems[indexPath.row] as! LocationModel
        
        //Manually call segue to detail view controller
        //self.performSegue(withIdentifier: "testSegue", sender: self)
        self.present(self.avPlayerViewController, animated: true) { () -> Void in
            self.avPlayerViewController.player?.play()
        }
        
    }
    
    //Function to perform segue to the TestViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    
    }
    
    
}

