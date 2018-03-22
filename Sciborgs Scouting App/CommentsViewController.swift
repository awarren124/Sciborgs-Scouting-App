//
//  CommentsViewController.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/21/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    var comment = ""
    
    @IBOutlet weak var commentTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.text = comment
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
