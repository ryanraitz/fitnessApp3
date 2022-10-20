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
        //let monthNumber = getMonth()
        //print(monthNumber)
        //let dataBaseName = ""
        //let fullDataBaseName = dataBaseName+monthNumber
        //print(fullDataBaseName)
        rootref = Database.database().reference()
        rootref.child("golfAppData").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var myDictionary = [String:Any]()
            //var myDict = [String:Any]()
            let locations = NSMutableArray()
            //let locationsTwo = NSMutableArray()
            
            //print(snapshot.children)
            //var i: Int = 1;
//            var x = 0
//            var prevID = 0
//            var rawCount = 1189
            var childCount = 0
            //var locationCount = 0
            for child in snapshot.children
            {
                childCount = (childCount + 1)
                let snap = child as! DataSnapshot
                //print(snap)
                let location = LocationModel()
                //let location2 = LocationModel()
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
                    
                    
                    if let userID = myDictionary["userID"] as? String,
                        let userName = myDictionary["userName"] as? String,
                        let userFirstName = myDictionary["userFirstName"] as? String,
                        let userEmail = myDictionary["userEmail"] as? String,
                        let userCredits = myDictionary["userCredits"] as? Int,
                        let userVideos = myDictionary["userVideos"] as? Dictionary<String, Any>,
                        let userCreditsString = myDictionary["userCreditsString"] as? String,
                        let userSubscriptionID = myDictionary["userSubscriptionID"] as? String
                    {
                        
                        location.userID! = userID
                        location.userName = userName
                        location.userFirstName = userFirstName
                        location.userEmail = userEmail
                        location.userCredits = userCredits
                        location.userVideos = userVideos
                        location.userCreditsString = userCreditsString
                        location.userSubscriptionID = userSubscriptionID
                        //i += 1
                        
                        
                        //print(location)
                    }
                    //print(location)
                    
                }
                //let location2 = LocationModel()
               /* for p in myDictionary {
                    //rawCount += 1
                    if let person = p.value as? [String:Any]
                    {
                        rawCount += 1
                        //print(person["userName"] as! String)
                        if(person["userName"] as! String == "1")
                        {
                            location2.userID = person["userID"] as? String
                            location2.userName = person["userName"] as? String
                            location2.userFirstName = person["userFirstName"] as? String
                            location2.userEmail = person["userEmail"] as? String
                            location2.userCredits = person["userCredits"] as? String
                            location2.userVideos = person["userVideos"] as? String
                            location2.exerciseDescription = person["exerciseDescription"] as? String
                            location2.mmC = person["mmC"] as? String
                        }
                    //print(location2)
                    //locationsTwo.add(location2)
                    }
                } */
                //print(locationsTwo)
                //print(location2)
                //Week 2 = Hypertrophy
//                if self.getWeek() == 2 || self.getWeek() == 6 || self.getWeek() == 10 || self.getWeek() == 14 || self.getWeek() == 18 || self.getWeek() == 22 || self.getWeek() == 26 || self.getWeek() == 30 || self.getWeek() == 34 || self.getWeek() == 38 || self.getWeek() == 42 || self.getWeek() == 46 || self.getWeek() == 50
//                {
//                    //print("rawCount count: ",rawCount)
//                  /*while(rawCount != 0)
//                  {
//                      if(location.userName == "1" && location.userFirstName == "2")
//                      {
//                            locationsTwo.add(location)
//                            print("location added")
//                      }
//                      else
//                      {
//                            rawCount = (rawCount - 1)
//                            print("location not added ", rawCount)
//                      }
//
//                  } */
//                    /*    userName                                 userFirstName
//                     1 = Sunday/Shoulders                        1 = Heavy
//                     2 = Monday/Legs                        2 = Hypertrophy
//                     3 = Tuesday/Back
//                     4 = Wednesday/Arms
//                     5 = Thursday/Chest
//                     6 = Friday/Abs
//                     7 = Saturday/Arms                                      */
//                    print("locationTwo count: ", locationsTwo.count)
//
//                    if(location.userName == "1" && location.userFirstName == "2")
//                    {
//                        locationsTwo.add(location)
//                        print("location added")
//
//                       /* let currentID:Int? = Int(location.userID!)
//
//                        if(locations.count == 0 && location.userEmail! == "Pyramid Set")
//                        {
//                            locations.add(location)
//                            prevID = currentID!
//                        }
//                        else if(locations.count < 5 && locations.count >= 1)
//                        {
//                            //print(a!)
//                            //print(prevID)
//                            if(currentID! < prevID)
//                            {
//                                print("goal 2 inserted " + location.userID!)
//                                locations.insert(location, at: x-1)
//                            }
//                            else
//                            {
//                                print("goal 2 added " + location.userID!)
//                                locations.add(location)
//                                prevID = currentID!
//                            }
//
//                        }
//                        else
//                        {
//                            print("more than 5 added")
//                        }
//                        x+=1
//                        */
//                    }
//                    else
//                    {
//                        rawCount = (rawCount - 1)
//                        print("location not added ", rawCount)
//                    }
//
//                    if(rawCount == locationsTwo.count)
//                    {
//                        //let swiftArray = NSArray(array: locationsTwo) as? [String]
//                        //while(locationCount != locationsTwo.count)
//                        print("worked")
//                        print(locationsTwo[0])
//                        //if let swiftArray = locationsTwo as NSArray as? [String]
//                        //{
//                        let swiftArray: [String] = locationsTwo.compactMap { $0 as? String }
//                        //let swiftArray = locationsTwo as NSArray as? [String]
//                        //let swiftArray = locationsTwo.compactMap { $0 }
//                        print("worked again")
//                        print("count: ",locationsTwo.count)
//                        //var myDict : [Int:String]
//                        let scoreboard = swiftArray.reduce(into: [String: Any]()) { $0[$1] = 0 }
//
//                        print(scoreboard)
//                        //let hobby = (swiftArray[0]["userID"] as? [String])[0]
//
//
//                        //}
//
//                     }
//                                //if(locations.count == 0 && )
//                                //{
//
//                                //}
//                        //}
//
//
//
//                    //rawCount = (rawCount - 1)
//                    //print("outside of the loop")
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
//                    if(location.userName == "1" && location.userFirstName == "3")
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
//                                print("goal 3 inserted" + location.userID!)
//                                locations.insert(location, at: x-1)
//                            }
//                            else
//                            {
//                                print("goal 3 added" + location.userID!)
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
//                    if(location.userName == "1" && location.userFirstName == "4")
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
//                                print("goal 4 inserted" + location.userID!)
//                                locations.insert(location, at: x-1)
//                            }
//                            else
//                            {
//                                print("goal 4 added" + location.userID!)
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
//                    if(location.userName == "1" && location.userFirstName == "1")
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
//                                print("goal 1 inserted" + location.userID!)
//                                locations.insert(location, at: x-1)
//                            }
//                            else
//                            {
//                                print("goal 1 added" + location.userID!)
//                                locations.add(location)
//                                prevID = currentID!
//                            }
//
//                        }
//                        x+=1
//
//                    }
//                }
//
            }
            //print(locationsTwo[0])
            print(childCount)
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
        let weekOfYear = calendar.component(.weekOfYear, from: Date())
        //from: Date.init(timeIntervalSinceNow: 0)
        //var firstWeekday: Int
        //print(weekOfYear)
        //getMonth()
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
