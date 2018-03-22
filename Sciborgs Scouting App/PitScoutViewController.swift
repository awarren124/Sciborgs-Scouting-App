//
//  PitScoutViewController.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/20/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import UIKit
import SVProgressHUD

class PitScoutViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var teamNumField: UITextField!
    @IBOutlet weak var driveTypeField: UITextField!
    @IBOutlet weak var canClimbSegControl: UISegmentedControl!
    @IBOutlet weak var commentsTextView: UITextView!
    
    var teamNum = 0
    var driveType = ""
    var canClimb = false
    var comments = ""
    
    var canScoreInSwitch = false
    var canScoreInScale = false
    var canScoreInVault = false

    override func viewDidLoad() {
        super.viewDidLoad()
        teamNumField.delegate = self
        teamNumField.keyboardType = .numberPad
        commentsTextView.delegate = self
        driveTypeField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(PitScoutViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PitScoutViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        let tap = UITapGestureRecognizer(target: self, action: #selector(PitScoutViewController.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text == "Team #")
        {
            
            textField.text = ""
            textField.textColor = .black
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text == "")
        {
            
            textField.text = "Teaem #"
            textField.textColor = .gray
        }
    }
    
    
    @IBAction func canClimbSegControlValChanged(_ sender: UISegmentedControl) {
        canClimb = (sender.selectedSegmentIndex == 0 ? true : false)
    }
    
    
    @IBAction func scoringValueChanged(_ sender: UISwitch) {
        switch sender.tag {
        case 0: // switch
            canScoreInSwitch = sender.isOn
            break
        case 1: //scale
            canScoreInScale = sender.isOn
            break
        case 2: //vault
            canScoreInVault = sender.isOn
            break
        default:
            break
        }
    }
    
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }

    
    @objc func keyboardWillShow(notification: NSNotification) {
        print(commentsTextView.isFirstResponder)
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 && commentsTextView.isFirstResponder{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 && commentsTextView.isFirstResponder{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        
        if let teamNumText = teamNumField.text{
            if let teamNum = Int(teamNumText){
                canClimb = canClimbSegControl.selectedSegmentIndex == 0
                let ps = PitScout(teamNum: teamNum, driveType: driveTypeField.text!, canClimb: canClimb, canScoreInSwitch: canScoreInSwitch, canScoreInScale: canScoreInScale, canScoreInVault: canScoreInVault, comments: commentsTextView.text)
                DatabaseHandler.submitPitScout(pitScout: ps)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Pit Scout View Controller")
                var viewControllers = self.tabBarController?.viewControllers
                viewControllers?.remove(at: 2)
                viewControllers?.insert(vc, at: 2)
                tabBarController?.setViewControllers(viewControllers, animated: true)

                
            }else{
                SVProgressHUD.showError(withStatus: "Check that the team number is entered correctly")
                SVProgressHUD.dismiss(withDelay: 2)

            }
        }else{
            SVProgressHUD.showError(withStatus: "No team number")
            SVProgressHUD.dismiss(withDelay: 2)

        }
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
