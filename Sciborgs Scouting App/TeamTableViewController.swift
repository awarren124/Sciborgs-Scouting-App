//
//  TeamTableViewController.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/10/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import UIKit
import SVProgressHUD

class TeamTableViewController: UITableViewController {
    
    var team = Team()
    var teamNum: Int!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        DatabaseHandler.getTeam(teamNumber: teamNum, completion: { (team) in
            self.team = team
            print("team ps \(team.pitScout.values)")
            self.tableView.reloadData()
            self.tableView.cellForRow(at: IndexPath(row: 5, section: 0))?.accessoryType = .none
            SVProgressHUD.dismiss()
        })

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
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            print("Stats count: \(team.stats.count)")
            return team.stats.count
        case 1:
            return team.pitScout.values.count
        case 2:
            return team.scouts.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Stats"
        case 1:
            return "Pit Scout"
        default:
            return "Scouts"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch(indexPath.section){
        case 0: // stats
            let cell = tableView.dequeueReusableCell(withIdentifier: "Stat Cell Identifier", for: indexPath)
            let stat = Team.statOrder[indexPath.row]
            cell.textLabel?.text = stat
            let formatted = String(format: "%.2f", team.stats[stat]!)
            cell.detailTextLabel?.text = formatted//String(format: "%.2f", team.stats[stat]))//"\(EventData.testStats[stat])"
            return cell
        case 1: // pit scout
            let cell = tableView.dequeueReusableCell(withIdentifier: "Stat Cell Identifier", for: indexPath)
            let pitStat = PitScout.valuesOrder[indexPath.row]
            cell.textLabel?.text = pitStat
            let pitVal = team.pitScout.values[pitStat]!
            cell.detailTextLabel?.text = String(describing: pitVal)
            
            if cell.textLabel?.text == "Comments"{
                print("Disclosure thinky")
                print(cell.textLabel?.text)
                cell.accessoryType = .disclosureIndicator
            }else {
                cell.accessoryType = .none
            }
            
            return cell
        case 2: // scouts
            let cell = tableView.dequeueReusableCell(withIdentifier: "Scout Cell Identifier", for: indexPath)
            let scout = team.scouts[indexPath.row]//EventData.testScouts[indexPath.row]
            cell.textLabel?.text = "Match #\(scout.matchNum)"
            cell.detailTextLabel?.text = scout.author
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.textLabel?.text == "Comments" {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "Comments View Controller") as! CommentsViewController
            vc.comment = (cell?.detailTextLabel!.text!)!
            navigationController?.show(vc, sender: self)//?.present(vc, animated: true, completion: nil)
//            present(vc, animated: true, completion: nil)
        }
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
        if let vc = segue.destination as? ScoutTableViewController{
            if let cell = sender as? UITableViewCell{
                let selectedScout = team.scouts[(tableView.indexPath(for: cell)?.row)!]
                vc.scout = selectedScout
                vc.title = "Match \(selectedScout.matchNum) Scout"
            }
        }else if let vc = segue.destination as? CommentsViewController {
            if let cell = sender as? UITableViewCell{
                print("commentoooo \(cell.detailTextLabel!.text!)")
                vc.comment = cell.detailTextLabel!.text!
            }
        }
    }
    
    
}
