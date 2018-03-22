//
//  AutoScoutViewController.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/9/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import UIKit
import SVProgressHUD
import GoogleAPIClientForREST

class ScoutViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{

    static var teamNum = 1155
    static var matchNum = 1
    
    @IBOutlet weak var teamTextField: UITextField!
    @IBOutlet weak var matchNumTextField: UITextField!
    static var crossedLine = false
    static var disabled = false
    static var climbed = false
    static var switchAutoCubes = 0
    static var scaleAutoCubes = 0
    static var switchTeleCubes = 0
    static var scaleTeleCubes = 0
    static var oppSwitchTeleCubes = 0
    static var vaultCubes = 0
    static var comments = ""


    let stepDict: [Int : String] = [
        0 : "Switch Auto",
        1 : "Scale Auto",
        2 : "Switch Tele",
        3 : "Scale Tele",
        4 : "Opp Switch Tele",
        5 : "Vault"
    ]
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var scaleAutoLabel: UILabel!
    @IBOutlet weak var switchAutoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchTeleLabel: UILabel!
    @IBOutlet weak var scaleTeleLabel: UILabel!
    @IBOutlet weak var oppSwitchTeleLabel: UILabel!
    @IBOutlet weak var vaultLabel: UILabel!
    @IBOutlet weak var commentsTextView: UITextView!
    


    override func viewDidLoad() {

        super.viewDidLoad()
        if (commentsTextView) != nil{
            commentsTextView.delegate = self
        }
        if (teamTextField) != nil {
            teamTextField.delegate = self
            teamTextField.keyboardType = .numberPad
        }
        
        if (matchNumTextField) != nil {
            matchNumTextField.delegate = self
            matchNumTextField.keyboardType = .numberPad
        }
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ScoutViewController.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        switch stepDict[sender.tag]! {
        case "Switch Auto":
            ScoutViewController.switchAutoCubes = Int(sender.value)
            break
        case "Scale Auto":
            ScoutViewController.scaleAutoCubes = Int(sender.value)
            break
        case "Switch Tele":
            ScoutViewController.switchTeleCubes = Int(sender.value)
            break
        case "Scale Tele":
            ScoutViewController.scaleTeleCubes = Int(sender.value)
            break
        case "Opp Switch Tele":
            ScoutViewController.oppSwitchTeleCubes = Int(sender.value)
            break
        case "Vault":
            ScoutViewController.vaultCubes = Int(sender.value)
            break
        default:
            break
        }
        updateLabels()
    }

    @IBAction func crossedLineValueChanged(_ sender: UISegmentedControl) {
        ScoutViewController.crossedLine = (sender.selectedSegmentIndex == 0 ? true : false)
    }
    @IBAction func disabledValueChanged(_ sender: UISegmentedControl) {
        ScoutViewController.disabled = (sender.selectedSegmentIndex == 0 ? true : false)
    }
    @IBAction func climbedValueChanged(_ sender: UISegmentedControl) {
        ScoutViewController.climbed = (sender.selectedSegmentIndex == 0 ? true : false)
    }
    func updateLabels(){
        switch titleLabel.text!{
        case "Auto":
            switchAutoLabel.text = "\(ScoutViewController.switchAutoCubes)"
            scaleAutoLabel.text = "\(ScoutViewController.scaleAutoCubes)"
            break
        case "Teleop":
            switchTeleLabel.text = "\(ScoutViewController.switchTeleCubes)"
            scaleTeleLabel.text = "\(ScoutViewController.scaleTeleCubes)"
            oppSwitchTeleLabel.text = "\(ScoutViewController.oppSwitchTeleCubes)"
            vaultLabel.text = "\(ScoutViewController.vaultCubes)"

            break
        case "Post Match":
            break
            
        default:
            break
            
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Comments...")
        {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text == "") {
            textView.text = "Comments..."
            textView.textColor = .gray
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text == "") {
            if(textField == teamTextField){
                textField.text = "Team #"
            }else{
                textField.text = "Match #"
            }
            textField.textColor = .gray
        }else{
            if(textField == teamTextField){
                ScoutViewController.teamNum = Int(teamTextField.text!)!

            }else{
                ScoutViewController.matchNum = Int(matchNumTextField.text!)!

            }

        }

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text == "Team #" || textField.text == "Match #")
        {
            
            textField.text = ""
            textField.textColor = .black
        }
    }
    
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.showSuccess(withStatus: "Scout Submitted")
        SVProgressHUD.dismiss(withDelay: 0.7)
        ScoutViewController.comments = commentsTextView.text
//        print("\([ScoutViewController.switchAutoCubes,ScoutViewController.scaleAutoCubes, ScoutViewController.switchTeleCubes,ScoutViewController.scaleTeleCubes, ScoutViewController.oppSwitchTeleCubes,ScoutViewController.vaultCubes])")
//        print([ScoutViewController.disabled, ScoutViewController.crossedLine])
//        print(ScoutViewController.comments)
        
        let cubes: [String : Int] = [
            "SwitchAuto" : ScoutViewController.switchAutoCubes,
            "ScaleAuto" : ScoutViewController.scaleAutoCubes,
            "SwitchTele" : ScoutViewController.switchTeleCubes,
            "ScaleTele" : ScoutViewController.scaleTeleCubes,
            "OppSwitchTele" : ScoutViewController.oppSwitchTeleCubes,
            "Vault" : ScoutViewController.vaultCubes
        ]
        
        let other: [String : Bool] = [
            "Crossed Line" : ScoutViewController.crossedLine,
            "Disabled" : ScoutViewController.disabled,
            "Climbed" : ScoutViewController.climbed
        ]
        
//        print(teamTextField.text)
//        print(matchNumTextField.text)
        print("Comments: \(ScoutViewController.comments)")
        let scout = Scout(teamNum: ScoutViewController.teamNum, matchNum: ScoutViewController.matchNum, cubes: cubes, other: other, author: CurrentUser.user.profile.name.capitalized, comments: ScoutViewController.comments)
        DatabaseHandler.submitScout(scout: scout)
        if let pageVC = parent as? PageViewController {
            pageVC.clearFields()
        }
    }

    func clearFields(){
//        
//        ScoutViewController.crossedLine = false
//        ScoutViewController.disabled = false
//        ScoutViewController.climbed = false
//
//        
//        ScoutViewController.switchAutoCubes = 0
//        ScoutViewController.scaleAutoCubes = 0
//        ScoutViewController.switchTeleCubes = 0
//        ScoutViewController.scaleTeleCubes = 0
//        ScoutViewController.oppSwitchTeleCubes = 0
//        ScoutViewController.vaultCubes = 0
//        ScoutViewController.comments = ""
        
//        (self.view.viewWithTag(0) as! UIStepper).value = 0
//        (self.view.viewWithTag(1) as! UIStepper).value = 0
//        (self.view.viewWithTag(2) as! UIStepper).value = 0
//        (self.view.viewWithTag(3) as! UIStepper).value = 0
//        (self.view.viewWithTag(4) as! UIStepper).value = 0
//        (self.view.viewWithTag(5) as! UIStepper).value = 0
//
//        switch titleLabel.text!{
//        case "Auto":
//            teamTextField.text = "Team #"
//            teamTextField.textColor = .gray
//            matchNumTextField.text = "Match #"
//            matchNumTextField.textColor = .gray
//            switchAutoLabel.text = "0"
//            scaleAutoLabel.text = "0"
//            break
//        case "Teleop":
//            switchTeleLabel.text = "0"
//            scaleTeleLabel.text = "0"
//            oppSwitchTeleLabel.text = "0"
//            vaultLabel.text = "0"
//            break
//        case "Post Match":
//            break
//        default:
//            break
//        }
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "Page View Controller")
//        var viewControllers = self.tabBarController?.viewControllers
//        viewControllers?.remove(at: 0)//.remove(at: 0)
//        viewControllers?.insert(vc, at: 0)
//        tabBarController?.setViewControllers(viewControllers, animated: true)
//
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
