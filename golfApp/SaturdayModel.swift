//
//  SaturdayModel.swift
//  fitnessApp
//
//  Created by Ryan Raitz on 10/29/19.
//  Copyright © 2019 Ryan Raitz. All rights reserved.
//



import Foundation
import FirebaseDatabase
import Firebase

protocol SaturdayProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class SaturdayModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocol!
    
    var rootref: DatabaseReference!
    
    //Function to generate a snapshot of the Firebase database and return a locations object
    func downloadFirItems()
    {
        //let monthNumber = getMonth()
        //print(monthNumber)
        //let dataBaseName = "maleExercises"
        //let fullDataBaseName = dataBaseName+monthNumber
        //print(fullDataBaseName)
        rootref = Database.database().reference()
        rootref.child("golfAppData").observeSingleEvent(of: .value, with: { (snapshot) in
            
            //var myDictionary = [String:Any]()
            let locations = NSMutableArray()
            
            var x = 0
            var prevID = 0
            var cart = [String:String]()
            
            for child in snapshot.children
            {
                let snap = child as! DataSnapshot
                let location = LocationModel()
                
                for child in snap.children
                {
                    let snapchild = child as! DataSnapshot
                    let value = snapchild.value
                    let key = snapchild.key
                    //myDictionary.updateValue(value as! String, forKey: key)
                    
                    
                    if key == "userID"
                    {
                        location.userID = value as? String
                    }
                    if key == "userName"
                    {
                        location.userName = value as? String
                    }
                    if key == "userFirstName"
                    {
                        location.userFirstName = value as? String
                    }
                    if key == "userEmail"
                    {
                        location.userEmail = value as? String
                    }
                    if key == "userCredits"
                    {
                        print("tried to add int")
                    }
                    if key == "userVideos"
                    {
                        for snapc in snapchild.children
                        {
                            let snapchild2 = snapc as! DataSnapshot
                            let v = snapchild2.value
                            let k = snapchild2.key
                            let count = 0
                            //var cart = [(String:Any)]()
                            if k != ""
                            {
                                cart[k] = v as? String
                                //location.userVideos = [k:v] as! Dictionary<String, Any>
                            }
                        }
                        //print(cart)
                        location.userVideos = cart
                    }
                    if key == "userCreditsString"
                    {
                        location.userCreditsString = value as? String
                    }
                    if key == "userSubscriptionID"
                    {
                        location.userSubscriptionID = value as? String
                    }
                    if key == "userVideoCount"
                    {
                        location.userVideoCount = value as? Int
                    }
                    
                    //print(location)
                }
                if location.userID == Auth.auth().currentUser?.uid
                {
                    locations.add(location)
                }
//                //print(location)
//                //Even week = Hypertrophy
//                /* if self.getWeek() % 2 == 0
//                 {
//                 /*    userName                            userFirstName
//                 1 = Sunday/Shoulders                        1 = Heavy
//                 2 = Monday/Legs                        2 = Hypertrophy
//                 3 = Tuesday/Back
//                 4 = Wednesday/Arms
//                 5 = Thursday/Chest
//                 6 = Friday/Abs
//                 7 = Saturday/Arms                                      */
//                 if(location.userName == "7" && location.userFirstName == "2")
//                 {
//                 
//                 let currentID:Int? = Int(location.userID!)
//                 
//                 if(locations.count == 0)
//                 {
//                 locations.add(location)
//                 prevID = currentID!
//                 }
//                 else
//                 {
//                 //print(a!)
//                 //print(prevID)
//                 if(currentID! < prevID)
//                 {
//                 //print("inserted")
//                 locations.insert(location, at: x-1)
//                 }
//                 else
//                 {
//                 //print("added")
//                 locations.add(location)
//                 prevID = currentID!
//                 }
//                 
//                 }
//                 x+=1
//                 
//                 }
//                 }
//                 //Odd week = Heavy
//                 else
//                 {
//                 if(location.userName == "7" && location.userFirstName == "1")
//                 {
//                 
//                 let currentID:Int? = Int(location.userID!)
//                 
//                 if(locations.count == 0)
//                 {
//                 locations.add(location)
//                 prevID = currentID!
//                 }
//                 else
//                 {
//                 //print(a!)
//                 //print(prevID)
//                 if(currentID! < prevID)
//                 {
//                 //print("inserted")
//                 locations.insert(location, at: x-1)
//                 }
//                 else
//                 {
//                 //print("added")
//                 locations.add(location)
//                 prevID = currentID!
//                 }
//                 
//                 }
//                 x+=1
//                 
//                 }
//                 }
//                 
//                 } */
//                //Even week = Hypertrophy
//                if self.getWeek() == 2 || self.getWeek() == 6 || self.getWeek() == 10 || self.getWeek() == 14 || self.getWeek() == 18 || self.getWeek() == 22 || self.getWeek() == 26 || self.getWeek() == 30 || self.getWeek() == 34 || self.getWeek() == 38 || self.getWeek() == 42 || self.getWeek() == 46 || self.getWeek() == 50
//                {
//                    
//                    /*    userName                                 userFirstName
//                     1 = Sunday/Shoulders                        1 = Heavy
//                     2 = Monday/Legs                        2 = Hypertrophy
//                     3 = Tuesday/Back
//                     4 = Wednesday/Arms
//                     5 = Thursday/Chest
//                     6 = Friday/Abs
//                     7 = Saturday/Arms                                      */
//                    if(location.userName == "7" && location.userFirstName == "2")
//                    {
//                        
//                        let currentID:Int? = Int(location.userID!)
//                        
//                        if(locations.count == 0)
//                        {
//                            locations.add(location)
//                            prevID = currentID!
//                        }
//                        else
//                        {
//                            //print(a!)
//                            //print(prevID)
//                            if(currentID! < prevID)
//                            {
//                                //print("inserted")
//                                locations.insert(location, at: x-1)
//                            }
//                            else
//                            {
//                                //print("added")
//                                locations.add(location)
//                                prevID = currentID!
//                            }
//                            
//                        }
//                        x+=1
//                        
//                    }
//                }
//                else if self.getWeek() == 3 || self.getWeek() == 7 || self.getWeek() == 11 || self.getWeek() == 15 || self.getWeek() == 19 || self.getWeek() == 23 || self.getWeek() == 27 || self.getWeek() == 31 || self.getWeek() == 35 || self.getWeek() == 39 || self.getWeek() == 43 || self.getWeek() == 47 || self.getWeek() == 51
//                {
//                    
//                    /*    userName                                 userFirstName
//                     1 = Sunday/Shoulders                        1 = Heavy
//                     2 = Monday/Legs                        2 = Hypertrophy
//                     3 = Tuesday/Back
//                     4 = Wednesday/Arms
//                     5 = Thursday/Chest
//                     6 = Friday/Abs
//                     7 = Saturday/Arms                                      */
//                    if(location.userName == "7" && location.userFirstName == "3")
//                    {
//                        
//                        let currentID:Int? = Int(location.userID!)
//                        
//                        if(locations.count == 0)
//                        {
//                            locations.add(location)
//                            prevID = currentID!
//                        }
//                        else
//                        {
//                            //print(a!)
//                            //print(prevID)
//                            if(currentID! < prevID)
//                            {
//                                //print("inserted")
//                                locations.insert(location, at: x-1)
//                            }
//                            else
//                            {
//                                //print("added")
//                                locations.add(location)
//                                prevID = currentID!
//                            }
//                            
//                        }
//                        x+=1
//                        
//                    }
//                }
//                else if self.getWeek() == 4 || self.getWeek() == 8 || self.getWeek() == 12 || self.getWeek() == 16 || self.getWeek() == 20 || self.getWeek() == 24 || self.getWeek() == 28 || self.getWeek() == 32 || self.getWeek() == 36 || self.getWeek() == 40 || self.getWeek() == 44 || self.getWeek() == 48 || self.getWeek() == 52
//                {
//                    
//                    /*    userName                                 userFirstName
//                     1 = Sunday/Shoulders                        1 = Heavy
//                     2 = Monday/Legs                        2 = Hypertrophy
//                     3 = Tuesday/Back
//                     4 = Wednesday/Arms
//                     5 = Thursday/Chest
//                     6 = Friday/Abs
//                     7 = Saturday/Arms                                      */
//                    if(location.userName == "7" && location.userFirstName == "4")
//                    {
//                        
//                        let currentID:Int? = Int(location.userID!)
//                        
//                        if(locations.count == 0)
//                        {
//                            locations.add(location)
//                            prevID = currentID!
//                        }
//                        else
//                        {
//                            //print(a!)
//                            //print(prevID)
//                            if(currentID! < prevID)
//                            {
//                                //print("inserted")
//                                locations.insert(location, at: x-1)
//                            }
//                            else
//                            {
//                                //print("added")
//                                locations.add(location)
//                                prevID = currentID!
//                            }
//                            
//                        }
//                        x+=1
//                        
//                    }
//                }
//                    //Week 1 = Heavy
//                else
//                {
//                    if(location.userName == "7" && location.userFirstName == "1")
//                    {
//                        
//                        let currentID:Int? = Int(location.userID!)
//                        
//                        if(locations.count == 0)
//                        {
//                            locations.add(location)
//                            prevID = currentID!
//                        }
//                        else
//                        {
//                            //print(a!)
//                            //print(prevID)
//                            if(currentID! < prevID)
//                            {
//                                //print("inserted")
//                                locations.insert(location, at: x-1)
//                            }
//                            else
//                            {
//                                //print("added")
//                                locations.add(location)
//                                prevID = currentID!
//                            }
//                            
//                        }
//                        x+=1
//                        
//                    }
//                }
                
            }
            //print(locations)
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
    
    func getMonth() -> String
    {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        let month = components.month
        let myString = month?.description
        //print(myString!)
        return myString!
    }
    
}





