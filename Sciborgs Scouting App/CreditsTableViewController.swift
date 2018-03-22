//
//  CreditsTableViewController.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/11/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import UIKit

class CreditsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.becomeFirstResponder()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if(event?.subtype == UIEventSubtype.motionShake) {
            
            let url = NSURL(string: "https://icanhazdadjoke.com/")
            var request = URLRequest(url: (url as URL?)!)
            request.setValue("text/plain", forHTTPHeaderField: "Accept")
            URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
                let joke = String(data: data!, encoding: String.Encoding.utf8)!
                let alert = UIAlertController(title: "😂", message: joke, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "👍", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            }).resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            let url = URL(string: "http://www.iconbeast.com/")!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            
        }
    }

}
