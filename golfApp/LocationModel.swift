//
//  LocationModel.swift
//  fitnessApp
//
//  Created by Ryan Raitz on 10/15/19.
//  Copyright © 2019 Ryan Raitz. All rights reserved.
//

import Foundation

//Class to generate an NSObject containing the same elements from the workout table in the
//database. Formed to help with structuring saved data
class LocationModel: NSObject {
    
    //Properties(database fields/keys)
    var userID: String?
    var userName: String?
    var userFirstName: String?
    var userEmail: String?
    var userCredits: Int?
    var userVideos: Dictionary<String, Any>?
    var userCreditsString: String?
    var userSubscriptionID: String?
    var userVideoCount: Int?
    
    //Empty constructor
    override init()
    {
        
    }
    
    //Construct with all parameters
    init(userID: String, userName: String, userFirstName: String, userEmail: String, userCredits: Int, userVideos: Dictionary<String, Any>, userCreditsString: String, userSubscriptionID: String, userVideoCount: Int) {
        
        self.userID = userID
        self.userName = userName
        self.userFirstName = userFirstName
        self.userEmail = userEmail
        self.userCredits = userCredits
        self.userVideos = userVideos
        self.userCreditsString = userCreditsString
        self.userSubscriptionID = userSubscriptionID
        self.userVideoCount = userVideoCount
        
    }
    
    
    //Prints object's current state
    override var description: String {
        return "User ID: \(String(describing: userID)), User's Name: \(String(describing: userName)), User's First Name: \(String(describing: userFirstName)), User Email Address: \(String(describing: userEmail)), User Credit Count: \(String(describing: userCredits)), User Videos: \(String(describing: userVideos)), User Credits String: \(String(describing: userCreditsString)), User's Subscription ID: \(String(describing: userSubscriptionID)), User's Video Count: \(String(describing: userVideoCount))"
        
    }
    
    
}
