//
//  MatchScoutViewController.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/8/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import UIKit

class MatchScoutViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: view.frame.height)
        
        view1.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        view2.center = CGPoint(x: view.frame.width + (view.frame.width / 2), y: view.frame.height / 2)
        view3.center = CGPoint(x: (2 * view.frame.width) + view.frame.width / 2, y: view.frame.height / 2)

        
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
