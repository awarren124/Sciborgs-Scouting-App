//
//  Scout.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/10/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import Foundation

public struct Scout {
    
    static let numOfValues = 11
    static let cubeOrder = [
       "SwitchAuto",
       "ScaleAuto",
       "SwitchTele",
       "ScaleTele",
       "OppSwitchTele",
       "Vault"
    ]
    
    static let otherOrder = [
        "Crossed Line",
        "Disabled",
        "Climbed"
    ]
    
    
    var teamNum: Int = 0
    var matchNum: Int = 0
//    var switchAutoCubes: Int = 3
//    var scaleAutoCubes: Int = 4
//    var switchTeleCubes: Int = 1
//    var scaleTeleCubes: Int = 5
//    var oppSwitchTeleCubes: Int = 2
//    var vaultCubes: Int = 1
    var cubes: [String : Int] = [
        "SwitchAuto" : 0,
        "ScaleAuto" : 0,
        "SwitchTele" : 0,
        "ScaleTele" : 0,
        "OppSwitchTele" : 0,
        "Vault" : 0
    ]
    
    var other: [String : Bool] = [
        "Crossed Line" : false,
        "Disabled" : false,
        "Climbed" : false
    ]
    
    var comments: String = ""
//    var crossedLine: Bool = true
//    var disabled: Bool = false
//    var climbed: Bool = true
//    
    var author: String = ""
    
    
    func toSheetFormat() -> [[Any]] {
        var arr = [Any]()
        arr.append(teamNum)
        arr.append(matchNum)
        arr.append(author)
        //var cubesArray = [Int]()
        
        for key in Scout.cubeOrder {
        //    cubesArray.append(cubes[key]!)
            arr.append(cubes[key]!)
        }
        
        //arr.append(cubesArray)
        
        //var otherArray = [Bool]()
        for key in Scout.otherOrder {
            //otherArray.append(other[key]!)
            let b = other[key]!
            print("b is \(b)")
            print("NSNumber(value: b) is \(NSNumber(value: b))")
            arr.append(Int(NSNumber(value: b)))
        }
        
        arr.append(comments)
        //arr.append(otherArray)
        
        print([arr])
        return [arr]
        
    }
    
    init(data: [Any]) {
        print("data:  \(data)")
        teamNum = Int((data[0] as! NSString).intValue)
        matchNum = Int((data[1] as! NSString).intValue)
        author = data[2] as! String
        
        for i in 3...8 {
            if let val = (data[i] as? NSString)?.intValue{
                cubes [Scout.cubeOrder[i - 3]] = Int(val)
            }
        }
        
        for i in 9...11 {
            if let val = (data[i] as? NSString)?.intValue{
                if(Int(val) == 1){
                    other [Scout.otherOrder[i - 9]] = true
                }else{
                    other [Scout.otherOrder[i - 9]] = false

                }
            }

        }
        
        comments = (data[12] as! String)
        
        print(self)
//        other = [
//
//            ]
        
    }
    
    init(teamNum: Int, matchNum: Int, cubes: [String : Int], other: [String : Bool], author: String, comments: String){
        self.teamNum = teamNum
        self.matchNum = matchNum
        self.cubes = cubes
        self.other = other
        self.author = author
        self.comments = comments
    }

    init() {
        //asd
    }
}
