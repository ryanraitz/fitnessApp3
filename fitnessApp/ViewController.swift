//
//  ViewController.swift
//  fitnessApp
//
//  Created by Ryan Raitz on 10/15/19.
//  Copyright © 2019 Ryan Raitz. All rights reserved.
//

import UIKit
import Firebase

//View controller for exercises of a given day
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol, SundayProtocol, MondayProtocol, WednesdayProtocol, ThursdayProtocol, FridayProtocol, SaturdayProtocol  {
    
    //Properties
    
    var feedItems: NSArray = NSArray()
    var selectedLocation : LocationModel = LocationModel()
    
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
        
        //Initializing protocol based on which day of the week button was pressed
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
        
        //Table view styling
        listTableView.backgroundColor = .clear
        listTableView.layer.backgroundColor = UIColor.clear.cgColor
        
        //Navigation bar styling
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
    
    //Getting data from protocol
    func itemsDownloaded(items: NSArray)
    {
        
        feedItems = items
        self.listTableView.reloadData()
    }
    
    //Setting the size of the table view based on content size
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        //Return the number of feed items
        return feedItems.count
        
    }
    
    //Function to generate the workout title based on the selected day and goalID
    func getWorkoutTitle() -> String
    {
        let item: LocationModel = feedItems[1] as! LocationModel
        
        if(item.muscleGroupID == "1" && item.goalID == "1" || item.goalID == "3")
        {
            return "Shoulders (Strength)"
        }
        if(item.muscleGroupID == "1" && item.goalID == "2" || item.goalID == "4")
        {
            return "Shoulders (Hypertrophy)"
        }
        if(item.muscleGroupID == "2" && item.goalID == "1" || item.goalID == "3")
        {
            return "Legs (Strength)"
        }
        if(item.muscleGroupID == "2" && item.goalID == "2" || item.goalID == "4")
        {
            return "Legs (Hypertrophy)"
        }
        if(item.muscleGroupID == "3" && item.goalID == "1" || item.goalID == "3")
        {
            return "Back (Strength)"
        }
        if(item.muscleGroupID == "3" && item.goalID == "2" || item.goalID == "4")
        {
            return "Back (Hypertrophy)"
        }
        if(item.muscleGroupID == "4" && item.goalID == "1" || item.goalID == "3")
        {
            return "Arms (Strength)"
        }
        if(item.muscleGroupID == "4" && item.goalID == "2" || item.goalID == "4")
        {
            return "Arms (Hypertrophy)"
        }
        if(item.muscleGroupID == "5" && item.goalID == "1" || item.goalID == "3")
        {
            return "Chest (Strength)"
        }
        if(item.muscleGroupID == "5" && item.goalID == "2" || item.goalID == "4")
        {
            return "Chest (Hypertrophy)"
        }
        if(item.muscleGroupID == "6")
        {
            return "Abs"
        }
        else { return "aint"}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        //Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let muscleGroup : String = getWorkoutTitle()
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        
        //Get the location to be shown
        let item: LocationModel = feedItems[indexPath.row] as! LocationModel
        
        //Cell label styling
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
        myCell.textLabel!.text = item.exerciseName
        myCell.detailTextLabel!.text = item.repRange!
        
        //Cell styling
        myCell.layer.backgroundColor = UIColor.clear.cgColor
        myCell.backgroundColor = .clear
        
        //Set muscle group label
        muscleGroupLabel.text = muscleGroup
        
        return myCell
    }
    
    //Function to pass data to the TestViewController whenever a cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        //Set selected location to var
        selectedLocation = feedItems[indexPath.row] as! LocationModel
        
        //Manually call segue to detail view controller
        self.performSegue(withIdentifier: "testSegue", sender: self)
        
    }
    
    //Function to perform segue to the TestViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        //Get reference to the destination view controller
        let detailVC  = segue.destination as! TestViewController
        
        detailVC.selectedLocation = selectedLocation
    }
    
    
}

