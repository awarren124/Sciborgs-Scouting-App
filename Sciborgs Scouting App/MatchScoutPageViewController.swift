//
//  ViewController.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 11/1/17.
//  Copyright © 2017 Alexander Warren. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MatchScoutPageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    

    var ref: DatabaseReference!
    
    
    var events = [
        "Hudson Valley",
        "NYC",
        "Championships"
    ]
    
    var climbResponses = [
        "Yes",
        "No"
    ]
    
    @IBOutlet weak var ballNumberField: UITextField!
    @IBOutlet weak var teamNumberField: UITextField!
    @IBOutlet weak var eventPicker: UIPickerView!
    @IBOutlet weak var gearNumberField: UITextField!
    @IBOutlet weak var climbSegControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //let report =
        ballNumberField.delegate = self
        teamNumberField.delegate = self
        eventPicker.delegate = self
        gearNumberField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return events.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return events[row]
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        let key = ref.child("alex").key
        let team = teamNumberField.text!
        let comp = events[eventPicker.selectedRow(inComponent: 0)]
        let report = [
            "Balls" : ballNumberField.text,
            "Climbed" : climbResponses[climbSegControl.selectedSegmentIndex],
            "Gears" : gearNumberField.text
            ] as [String : Any]
        let update = ["Competitions/\(comp)/Teams/\(team)/\(key)/" : report]
        self.ref.updateChildValues(update)
    }
    

}

