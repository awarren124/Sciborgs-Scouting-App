//
//  Team.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/10/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import Foundation

public struct Team {
    
    var number: Int = 0
    var nickname: String = ""
    
    var scouts: [Scout] = [Scout]()
    
    var stats: [String : Double] = [String : Double]()
    
    public static let statOrder = [
        "Switch Cubes in Auto",
        "Scale Cubes in Auto",
        "Switch Cubes in Tele",
        "Scale Cubes in Tele",
        "Opponent Switch Cubes",
        "Cubes in Vault",
        "Crossed Line %",
        "Disabled %",
        "Climbed %"
    ]
    
    var pitScout = PitScout()
    
//    init(averages: [Any]) {
//        number = averages[0] as! Int
//        nickname = EventData.teamNames[EventData.teamNumbers.index(of: number)!]
//        //stats = [
////            "Cub
//        //]
//        scouts = [Scout]()
//        stats = [String: Double]()
//    }
    
}
