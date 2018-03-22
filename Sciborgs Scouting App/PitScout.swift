//
//  PitScout.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/20/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import Foundation

public class PitScout {
    var teamNum = 0
//    var driveType = ""
//    var canClimb = false
//    var canScoreInSwitch = false
//    var canScoreInScale = false
//    var canScoreInVault = false
//    var comments = ""
//
    var values : [String : Any] = [
        "Can Climb" : false,
        "Can Score In Switch" : false,
        "Can Score In Scale" : false,
        "Can Score In Vault" : false,
        "Drive Type" : "",
        "Comments" : ""
    ]
    
    static let valuesOrder = [
        "Drive Type",
        "Can Climb",
        "Can Score In Switch",
        "Can Score In Scale",
        "Can Score In Vault",
        "Comments"
    ]
    
    init(teamNum: Int, driveType: String, canClimb: Bool, canScoreInSwitch: Bool, canScoreInScale: Bool,canScoreInVault: Bool, comments: String) {
        self.teamNum = teamNum
        
        self.values["Drive Type"] = driveType
        self.values["Can Climb"] = canClimb
        self.values["Can Score In Switch"] = canScoreInSwitch
        self.values["Can Score In Scale"] = canScoreInScale
        self.values["Can Score In Vault"] = canScoreInVault
        self.values["Comments"] = comments



//
//        self.driveType = driveType
//        self.canClimb = canClimb
//        self.canScoreInVault = canScoreInVault
//        self.canScoreInScale = canScoreInScale
//        self.canScoreInSwitch = canScoreInSwitch
//        self.comments = comments
    }
    
    init() {
        
    }
    
    init(data: [Any]){
        self.values["Drive Type"] = data[0] as! String
        print(data[2])
        print(type(of: data[2]))
        self.values["Can Climb"] = (data[1] as! String == "TRUE")
        self.values["Can Score In Switch"] = (data[2] as! String == "TRUE")
        self.values["Can Score In Scale"] = (data[3] as! String == "TRUE")
        self.values["Can Score In Vault"] = (data[4] as! String == "TRUE")
        self.values["Comments"] = data[5] as! String

    }
    
    func toSheetFormat() -> [Any]{
        //return [driveType, canClimb, canScoreInSwitch, canScoreInScale, canScoreInVault, comments]
        var arr = [Any]()
        
        for key in PitScout.valuesOrder {
            arr.append(values[key])
        }
        return arr
    }
    
}
