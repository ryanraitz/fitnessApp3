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
    var exerciseID: String?
    var muscleGroupID: String?
    var goalID: String?
    var exerciseName: String?
    var repRange: String?
    var videoURL: String?
    var exerciseDescription: String?
    var mmC: String?
    
    //Empty constructor
    override init()
    {
        
    }
    
    //Construct with all parameters
    init(exerciseID: String, muscleGroupID: String, goalID: String, exerciseName: String, repRange: String, videoURL: String, exerciseDescription: String, mmC: String) {
        
        self.exerciseID = exerciseID
        self.muscleGroupID = muscleGroupID
        self.goalID = goalID
        self.exerciseName = exerciseName
        self.repRange = repRange
        self.videoURL = videoURL
        self.exerciseDescription = exerciseDescription
        self.mmC = mmC
        
    }
    
    
    //Prints object's current state
    override var description: String {
        return "Exercise ID: \(String(describing: exerciseID)), Muscle Group ID: \(String(describing: muscleGroupID)), Goal ID: \(String(describing: goalID)), Exercise Name: \(String(describing: exerciseName)), Rep Range: \(String(describing: repRange)), Video URL: \(String(describing: videoURL)), Exercise Description: \(String(describing: exerciseDescription)), Mind Muscle Connection: \(String(describing: mmC))"
        
    }
    
    
}
