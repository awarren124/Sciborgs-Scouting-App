//
//  MatchTeamsTableViewController.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/11/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import UIKit

class MatchTeamsTableViewController: UITableViewController {

    var matchNumber: Int!
    var teams = [String : [Int]]()
    var teamAverages = [Int : Double]()
    override func viewDidLoad() {
        super.viewDidLoad()
        TBAApi.getTeamsInMatchWith(num: matchNumber) { (teams) in
            self.teams = teams
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            let teamNums = teams["blue"]! + teams["red"]!//teams.values.flatMap { $0 }
            print("teamNums: \(teamNums)")
            for teamNum in teamNums {
                
                DatabaseHandler.getTeam(teamNumber: teamNum, completion: { (team) in
                    //                self.team = team
                    print("team ps \(team.pitScout.values)")
                    print(team.stats)
                    let vals = Array(team.stats.values)
                    
                    print("vals: \(vals)")
                    var sum: Double = 0
                    
                    for key in Team.statOrder[0...5] {
                        print("key: \(key)")
                        if let val = team.stats[key] {
                            sum += val
                        }
                    }
                    
                    
//                    let sum = vals.reduce(0, { x, y in
//                        x + y
//                    })
                    
                    print("sum: \(sum)")
                    
                    self.teamAverages[teamNum] = sum
                    self.tableView.reloadData()
                    //                SVProgressHUD.dismiss()
                })
            }

        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Blue"
        }
        return "Red"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Team Cell Identifier", for: indexPath)

        if(indexPath.section == 0){
            cell.textLabel?.text = "\(teams["blue"]![indexPath.row])"
            if let sum = teamAverages[teams["blue"]![indexPath.row]] {
                cell.detailTextLabel?.text = "\(sum)"//EventData.nameForTeam(num: teams["blue"]![indexPath.row])
            }else{
                cell.detailTextLabel?.text = "N/A"
            }
        }else{
            cell.textLabel?.text = "\(teams["red"]![indexPath.row])"
            if let sum = teamAverages[teams["red"]![indexPath.row]] {
                cell.detailTextLabel?.text = "\(sum)"//EventData.nameForTeam(num: teams["blue"]![indexPath.row])
            }else{
                cell.detailTextLabel?.text = "N/A"
            }
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TeamTableViewController{
            if let cell = sender as? UITableViewCell{
                let num = Int((cell.textLabel?.text!)!)!
                vc.teamNum = num
                vc.title = "Team \(num)"
//                DatabaseHandler.getTeam(teamNumber: num, completion: { (team) in
//                    vc.team = team
//                })
//                DatabaseHandler.getTeam(teamNumber: num, completion: { (team) in
//                    vc.team = team
//                })
            }
        }

    }
    

}
