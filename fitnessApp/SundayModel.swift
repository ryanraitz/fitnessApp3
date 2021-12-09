//
//  SundayModel.swift
//  fitnessApp
//
//  Created by Ryan Raitz on 10/29/19.
//  Copyright © 2019 Ryan Raitz. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase


protocol SundayProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class SundayModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocol!
    
    var rootref: DatabaseReference!
    
    var ref2: DatabaseReference!
    
    var i: Int = 1;
    
    //Function to generate a snapshot of the Firebase database and return a locations object
    func downloadFirItems()
    {
        rootref = Database.database().reference()
        rootref.child("maleExercises").observeSingleEvent(of: .value, with: { (snapshot) in
        
            var myDictionary = [String:Any]()
            let locations = NSMutableArray()
            
            //print(snapshot.children)
           //var i: Int = 1;
           var x = 0
           var prevID = 0
           for child in snapshot.children
           {
                //print(snap)
                let snap = child as! DataSnapshot
                //print(snap)
                let location = LocationModel()
                //var i: Int = 1;
                for child in snap.children
                {
                    //i = 1;
                    let snapchild = child as! DataSnapshot
                    //print(snapchild)
                    let value = snapchild.value
                    let key = snapchild.key
                    //var i: Int = 1
                    myDictionary.updateValue(value as! String, forKey: key)
                    
                    
                    if let exerciseID = myDictionary["exerciseID"] as? String,
                        let muscleGroupID = myDictionary["muscleGroupID"] as? String,
                        let goalID = myDictionary["goalID"] as? String,
                        let exerciseName = myDictionary["exerciseName"] as? String,
                        let repRange = myDictionary["repRange"] as? String,
                        let videoURL = myDictionary["videoURL"] as? String,
                        let exerciseDescription = myDictionary["exerciseDescription"] as? String,
                        let mmC = myDictionary["mmC"] as? String
                    {
                        
                            location.exerciseID = exerciseID
                            location.muscleGroupID = muscleGroupID
                            location.goalID = goalID
                            location.exerciseName = exerciseName
                            location.repRange = repRange
                            location.videoURL = videoURL
                            location.exerciseDescription = exerciseDescription
                            location.mmC = mmC
                            //i += 1
                        
                        
                        //print(location)
                    }
                    //print(location)
                    
                }
                //print(location)
                //Even Week = Hypertrophy
                //var x = 6
                if self.getWeek() % 2 == 0
                {
                    
                /*    muscleGroupID                                 goalID
                      1 = Sunday/Shoulders                        1 = Heavy
                      2 = Monday/Legs                        2 = Hypertrophy
                      3 = Tuesday/Back
                      4 = Wednesday/Arms
                      5 = Thursday/Chest
                      6 = Friday/Abs
                      7 = Saturday/Arms                                      */
                    if(location.muscleGroupID == "1" && location.goalID == "2")
                    {
                                        
                        let currentID:Int? = Int(location.exerciseID!)
            
                        if(locations.count == 0)
                        {
                            locations.add(location)
                            prevID = currentID!
                        }
                        else
                        {
                            //print(a!)
                            //print(prevID)
                            if(currentID! < prevID)
                            {
                                //print("inserted")
                                locations.insert(location, at: x-1)
                            }
                            else
                            {
                                //print("added")
                                locations.add(location)
                                prevID = currentID!
                            }
                            
                        }
                        x+=1
                                
                    }
                }
                //Odd week = Heavy
                else
                {
                    if(location.muscleGroupID == "1" && location.goalID == "1")
                    {
                                        
                        let currentID:Int? = Int(location.exerciseID!)
            
                        if(locations.count == 0)
                        {
                            locations.add(location)
                            prevID = currentID!
                        }
                        else
                        {
                            //print(a!)
                            //print(prevID)
                            if(currentID! < prevID)
                            {
                                //print("inserted")
                                locations.insert(location, at: x-1)
                            }
                            else
                            {
                                //print("added")
                                locations.add(location)
                                prevID = currentID!
                            }
                            
                        }
                        x+=1
                                
                    }
                }
            
           }
            
        //print(locations[2])
        //Execute itemsDownloaded() protocol to share data to ViewController
        DispatchQueue.main.async(execute: { () -> Void in
                        
            self.delegate.itemsDownloaded(items: locations)
                        
        })
      })
    }
    

    
    //Function to return which week of the year it is for heavy/hypertrophy workout changes
    func getWeek() -> Int
    {
        let calendar = Calendar.current
        let weekOfYear = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
        //print(weekOfYear)
        return weekOfYear
    }
    
}
