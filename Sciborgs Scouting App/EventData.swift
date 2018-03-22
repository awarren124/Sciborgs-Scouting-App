//
//  EventData.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/10/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import Foundation

public class EventData {
    
    public static var eventID = "2017nysu"
    
    public static let teamNumbers =
        [
            1155,
            1156,
            1382,
            1600,
            1635,
            1665,
            1796,
            1880,
            1923,
            20,
            2265,
            250,
            2601,
            2869,
            2872,
            2875,
            3004,
            303,
            3044,
            3204,
            3314,
            3419,
            353,
            369,
            395,
            3950,
            4091,
            4122,
            4571,
            5016,
            5123,
            5202,
            527,
            5599,
            5781,
            5814,
            5943,
            5955,
            6024,
            6058,
            6300,
            639,
            6401,
            6593,
            6601,
            6636,
            6648,
            810
    ]
    
    public static let teamNames =
        [
            "SciBorgs",
            "Under Control",
            "ETEP Team",
            "ROBO KINGS AND QUEENS",
            "TECHNOTICS",
            "Weapons of Mass Construction",
            "RoboTigers",
            "Warriors of East Harlem",
            "The MidKnight Inventors",
            "The Rocketeers",
            "Fe Maidens",
            "The Dynamos",
            "Steel Hawks",
            "Regal Eagles",
            "CyberCats",
            "CyberHawks",
            "Bronx Knights",
            "The T.E.S.T. Team",
            "Team 0xBE4",
            "Steampunk Penguins",
            "Mechanical Mustangs",
            "RoHawks",
            "POBots",
            "High Voltage Robotics",
            "2 Train Robotics",
            "RoboGym Robotics",
            "DRIFT",
            "Ossining O-Bots",
            "Rambots",
            "Huntington Robotics",
            "Mechadogs",
            "NewRo Bots",
            "Red Dragons",
            "The Sentinels",
            "Petchey Robotics Team ",
            "ROBOTA",
            "The Bad News Gears",
            "Trailblazers",
            "R Factor",
            "ROBOTURK",
            "Northwood School Robotics",
            "Code Red Robotics",
            "Clarkstown North 8-Bit Rams",
            "Lions",
            "Easy Company",
            "Full Metal Beavers",
            "MechaSpartans",
            "The Mechanical Bulls"
    ]
    
    public static let testStats = [
        "Cubes in auto" : 0.4,
        "Cubes in vault" : 4.3,
        "Climbing percent" : 50,
    ]
    
    public static let testScouts = [
        Scout(),
        Scout()
    ]
    
    public static func nameForTeam(num: Int) -> String {
        let index = teamNumbers.index(of: num)
        return teamNames[index!]
    }
    
    public static func updateEvent(){
        DatabaseHandler.getCurrentEvent(completion: {(event) in
            self.eventID = event
            print(event)
        })
    }
    
}
