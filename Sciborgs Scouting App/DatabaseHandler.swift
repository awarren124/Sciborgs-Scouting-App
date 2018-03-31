//
//  FirebaseHandler.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/11/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import Foundation
import UIKit
import GoogleAPIClientForREST
import GoogleSignIn
//import GTMSessionFetcher/GTMSessionFetcher
//import GTMSessionFetcher/GTMSessionFetcherService
import GTMSessionFetcher
import SVProgressHUD

public class DatabaseHandler {
    
    private static let service = GTLRSheetsService()
    static let spreadsheetId = "1_mrTf0ELjHG66kDjj2beDBOY0GMvCNshQacLT0UatT8"
    
    
    public static func getTeam(teamNumber: Int, completion: @escaping (Team) -> ()) {
        
        if var index = EventData.teamNumbers.index(of: teamNumber) {
            index += 2
            let range = "A\(index):J\(index)"
            let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range: "Averages!\(range)")
            print(range)
            
            service.apiKey = AuthInfo.sheetsAPIKey
            service.authorizer = CurrentUser.user.authentication.fetcherAuthorizer()
            
            //        GTLRSheets_BooleanCondition
            
            service.executeQuery(query, completionHandler: { (ticket, response, error) in
                if let error = error{
                    return
                }
                if let vals = response as? GTLRSheets_ValueRange {
                    var averages = [Any]()
                    if vals.values != nil{
                        averages = vals.values![0]
                    }
                    //                vals.values.va
                    var stats = [String: Double]()
                    
                    for (i, val) in averages.enumerated() {
                        print(type(of: val))
                        if i != 0 {
                            if let stat = (val as? NSString)?.doubleValue {
                                print("here")
                                print(Team.statOrder[i - 1])
                                stats[Team.statOrder[i - 1]] = stat
                            }
                        }
                    }
                    //                print(stats)
                    
                    let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range: "Averages!K\(index):P\(index)")
                    service.executeQuery(query, completionHandler: { (ticket, response, error) in
                        var ps = PitScout()
                        print("here1")
                        if let vals = response as? GTLRSheets_ValueRange {
                            print("???")
                            if vals.values != nil {
                                let items = vals.values![0]
                                ps = PitScout(data: items)
                            }
                        }
                        
                        
                        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range: "Scouts!A2:M")
                        
                        service.executeQuery(query, completionHandler: { (ticket, response, error) in
                            if let error = error{
                                print(error.localizedDescription)
                            }
                            var scouts = [Scout]()
                            print("response")
                            if let vals = response as? GTLRSheets_ValueRange {
                                print(vals)
                                for row in vals.values! {
                                    //                            print(row)
                                    //                            print(row[0])
                                    print((row[0] as! NSString).intValue)
                                    
                                    //                            if ((row[0] as? NSString)?.intValue) == teamNumber {
                                    if let num = ((row[0] as? NSString)?.intValue){
                                        if num == teamNumber{
                                            //                                print("here")
                                            //                                print("row")
                                            //                                print(row)
                                            let scout = Scout(data: row)
                                            print(scout)
                                            //                                scouts.append(Scout(data: row))
                                            scouts.append(scout)
                                        }
                                    }
                                }
                            }
                            
                            completion(Team(number: teamNumber, nickname: EventData.nameForTeam(num: teamNumber), scouts: scouts, stats: stats, pitScout: ps))
                            
                        })
                    })
                    
                    //return Team(averages: vals.values![0])
                }
            })
            //        service.executeQuery(query, completionHandler: { (ticket, _, error) in
            //            if let error = error {
            //                print(error.localizedDescription)
            //            }
            //
            //        })
            
            
            //        return Team(number: teamNumber, nickname: "lololol", scouts: EventData.testScouts, stats: EventData.testStats)
        }else{
            return
        }
    }
    
    public static func submitScout(scout: Scout){
        
        
        
        let values = GTLRSheets_ValueRange(json: ["majorDimension": "ROWS",
                                                  "values": scout.toSheetFormat()])
        let query = GTLRSheetsQuery_SpreadsheetsValuesAppend.query(withObject: values, spreadsheetId: spreadsheetId, range: "Scouts!A1")
        query.insertDataOption = "INSERT_ROWS"
        query.valueInputOption = "USER_ENTERED"
        service.apiKey = AuthInfo.sheetsAPIKey
        service.authorizer = CurrentUser.user.authentication.fetcherAuthorizer()
        service.executeQuery(query, completionHandler: { (ticket, _, error) in
            if let error = error {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                SVProgressHUD.dismiss(withDelay: 2)
                return
            }else{
                SVProgressHUD.showSuccess(withStatus: "Scout Submitted")
                SVProgressHUD.dismiss(withDelay: 0.7)
            }
            
        })
        print("Scout submitted")
    }
    
    public static func submitPitScout(pitScout: PitScout){
        
        if var index = EventData.teamNumbers.index(of: pitScout.teamNum){
            index += 2
            let values = GTLRSheets_ValueRange(json: ["majorDimension": "ROWS",
                                                      "values": [pitScout.toSheetFormat()]])
            let query = GTLRSheetsQuery_SpreadsheetsValuesUpdate.query(withObject: values, spreadsheetId: spreadsheetId, range: "Averages!K\(index):P\(index)")
            query.valueInputOption = "USER_ENTERED"
            service.apiKey = AuthInfo.sheetsAPIKey
            service.authorizer = CurrentUser.user.authentication.fetcherAuthorizer()
            service.executeQuery(query, completionHandler: { (ticket, _, error) in
                if let error = error {
                    SVProgressHUD.showError(withStatus: error.localizedDescription)
                    SVProgressHUD.dismiss(withDelay: 2)
                    
                }else{
                    SVProgressHUD.showSuccess(withStatus: "Pit Scout Submitted")
                    SVProgressHUD.dismiss(withDelay: 0.7)
                }
                
            })
            
        }else{
            SVProgressHUD.showError(withStatus: "Team Number not correct")
            SVProgressHUD.dismiss(withDelay: 0.7)
        }
        
        print("Scout submitted")
    }
    
    public static func getCurrentEvent(completion: @escaping (String) -> ()) {
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range: "EventDataReference!A1")
        query.majorDimension = "ROWS"
        service.apiKey = AuthInfo.sheetsAPIKey
        service.authorizer = CurrentUser.user.authentication.fetcherAuthorizer()
        service.executeQuery(query) { (ticket, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let vals = response as? GTLRSheets_ValueRange {
                completion(vals.values![0][0] as! String)
            }
        }
    }
    //    func showAlert(title : String, message: String) {
    //        let alert = UIAlertController(
    //            title: title,
    //            message: message,
    //            preferredStyle: UIAlertControllerStyle.alert
    //        )
    //        let ok = UIAlertAction(
    //            title: "OK",
    //            style: UIAlertActionStyle.default,
    //            handler: nil
    //        )
    //        alert.addAction(ok)
    ////        present(alert, animated: true, completion: nil)
    //    }
    
}
