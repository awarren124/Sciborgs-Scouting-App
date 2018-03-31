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
            1230,
            1600,
            1660,
            1796,
            1880,
            2265,
            2344,
            2579,
            2895,
            3004,
            3204,
            333,
            334,
            335,
            3419,
            354,
            369,
            371,
            3760,
            395,
            4012,
            4263,
            4299,
            4383,
            4571,
            4640,
            4773,
            4856,
            5298,
            5421,
            5599,
            5665,
            5781,
            5800,
            5806,
            5891,
            6195,
            6353,
            640,
            6416,
            6590,
            6593,
            6648,
            6873,
            694,
            6988,
            7036,
            7268,
            7272,
            743
    ]
    
    public static let teamNames =
        [
            "SciBorgs",
            "The Lehman Lionics",
            "ROBO KINGS AND QUEENS",
            "Harlem Knights",
            "RoboTigers",
            "Warriors of East Harlem",
            "Fe Maidens",
            "The Saunders Droid Factory ",
            "LIC Robodogs",
            "Blazenbots",
            "Bronx Knights",
            "Steampunk Penguins",
            "MEGALODONS",
            "TechKnights",
            "Skillz Tech Gear Botz",
            "RoHawks",
            "G-House Pirates",
            "High Voltage Robotics",
            "Cyber Warriors",
            "Aerospace",
            "2 Train Robotics",
            "Bad News Bots",
            "CyberDragon",
            "BCS Robo Sharks",
            "The P-TECH Fly-Bots",
            "Rambots",
            "Metallic Panthers 4640",
            "Steel Horses",
            "Double X",
            "E-TECH CHARGERS",
            "Birch Bots",
            "The Sentinels",
            "SPARC",
            "Petchey Robotics Team ",
            "Magic Island Robotics",
            "Horace Mann School",
            "UASGC Robosquad",
            "GOLDBOTS",
            "Zodiac",
            "Robo Elite",
            "MEV MAKERS",
            "SaviTech",
            "Lions",
            "MechaSpartans",
            "The Generals",
            "StuyPulse",
            "ACI 35",
            "Beta Gamma Robotica",
            "BCNY Gerry Robotic Lions (East Harlem)",
            "High School for Environmental Studies",
            "Technobots"
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
        if let index = teamNumbers.index(of: num) {
            return teamNames[index]
        }else{
            return ""
        }
    }
    
    public static func updateEvent(){
        DatabaseHandler.getCurrentEvent(completion: {(event) in
            self.eventID = event
            print(event)
        })
    }
    
}
