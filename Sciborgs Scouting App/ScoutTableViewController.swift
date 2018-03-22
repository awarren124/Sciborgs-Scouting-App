//
//  ScoutTableViewController.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/10/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import UIKit

class ScoutTableViewController: UITableViewController {

    var scout: Scout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Scout.numOfValues
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Scout Info Cell", for: indexPath)

        if(indexPath.row == 0){
//            print(scout)
            cell.detailTextLabel?.text = scout.author
            cell.textLabel?.text = "Author"
        }else if(indexPath.row < scout.cubes.count + 1){
            print(indexPath.row - 1)
            cell.detailTextLabel?.text = "\(scout.cubes[Scout.cubeOrder[indexPath.row - 1]]!)"
            cell.textLabel?.text = Scout.cubeOrder[indexPath.row - 1]
        }else if(indexPath.row < scout.other.count + scout.cubes.count + 1){
            cell.detailTextLabel?.text = "\(scout.other[Scout.otherOrder[indexPath.row - (scout.cubes.count + 1)]]!)"
            cell.textLabel?.text = "\(Scout.otherOrder[indexPath.row - (scout.cubes.count + 1)])"
        }else{
            cell.detailTextLabel?.text = scout.comments
            cell.textLabel?.text = "Comments"
            cell.accessoryType = .disclosureIndicator
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.textLabel?.text == "Comments" {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "Comments View Controller") as! CommentsViewController
            vc.comment = (cell?.detailTextLabel!.text!)!
            navigationController?.show(vc, sender: self)
        }
    }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
