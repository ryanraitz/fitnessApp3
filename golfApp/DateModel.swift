//
//  DateModel.swift
//  golfApp
//
//  Created by Ryan Raitz on 10/12/22.
//  Copyright © 2022 Ryan Raitz. All rights reserved.
//

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
class DateModel: NSObject {
    
    //Properties(database fields/keys)
    var videoDate: String?
    
    //Empty constructor
    override init()
    {
        
    }
    
    //Construct with all parameters
    init(videoDate: String) {
        
        self.videoDate = videoDate
        
    }
    
    
    //Prints object's current state
    override var description: String {
        return "Video Date: \(String(describing: videoDate))"
        
    }
    
    
}
