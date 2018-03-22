//
//  TBAApi.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/10/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TBAApi {
    
    static let baseURL = "https://www.thebluealliance.com/api/v3"
    
    public static func get1155Matches(completion: @escaping ([Int]) -> ()){
//        let url = NSURL(string: "https://www.thebluealliance.com/api/v3/team/frc1155/event/2017nysu/matches/simple")
//        print((url as URL?)!)
//        var request = URLRequest(url: (url as URL?)!)
//        request.setValue(AuthInfo.appID, forHTTPHeaderField: "X-TBA-App-Id")
//        request.setValue(AuthInfo.tbaKey, forHTTPHeaderField: "X-TBA-Auth-Key")
//        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
//            let jsonArray = JSON(data: data!).arrayValue
//            var matchNums = [Int]()
//            for json in jsonArray {
//                let match = json.dictionaryValue
//                matchNums.append(Int(match["match_number"]!.int!))
//            }
//            completion(matchNums)
//        }).resume()
        getJSONFrom(url: "/team/frc1155/event/\(EventData.eventID)/matches/simple", completion: { (json) in
            let jsonArray = json.arrayValue
            var matchNums = [Int]()
            for json in jsonArray {
                let match = json.dictionaryValue
                matchNums.append(Int(match["match_number"]!.int!))
            }
            completion(matchNums)
        })
    }
    
    public static func getTeamsInMatchWith(num: Int, completion: @escaping ([String : [Int]]) -> ()){
        getJSONFrom(url: "/team/frc1155/event/\(EventData.eventID)/matches/simple") { (json) in
            let jsonArray = json.arrayValue
            for json in jsonArray {
                if Int(json.dictionaryValue["match_number"]!.int!) == num {
                    let alliances = json.dictionaryValue["alliances"]!
                    
                    let blueTeams = alliances["blue"]["team_keys"].arrayObject as! [String]
                    let redTeams = alliances["red"]["team_keys"].arrayObject as! [String]
//                    print("blue teams: \(blueTeams)")
//                    print("red teams: \(redTeams)")
                    var blueTeamNums = [Int]()
                    var redTeamNums = [Int]()
                    for team in blueTeams {
                        let index = team.index(team.startIndex, offsetBy: 3)
                        let num = Int(team.suffix(from: index))!
                        redTeamNums.append(num)
                    }
                    for team in redTeams {
                        let index = team.index(team.startIndex, offsetBy: 3)
                        let num = Int(team.suffix(from: index))!
                        blueTeamNums.append(num)
                    }
                    let teams = [
                        "blue" : blueTeamNums,
                        "red" : redTeamNums
                    ]
//                    print(teams)
                    completion(teams)
                    
                }
            }
        }
    }
    
    public static func getJSONFrom(url: String, completion: @escaping (JSON) -> ()){
        let url = NSURL(string: "\(baseURL)\(url)")
        var request = URLRequest(url: (url as URL?)!)
        request.setValue(AuthInfo.appID, forHTTPHeaderField: "X-TBA-App-Id")
        request.setValue(AuthInfo.tbaKey, forHTTPHeaderField: "X-TBA-Auth-Key")
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            let json = JSON(data: data!)
            completion(json)
        }).resume()
    }
}
