//
//  PageViewController.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 3/8/18.
//  Copyright © 2018 Alexander Warren. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    

    // MARK: Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let a = viewController as? AutoScoutViewController else{
//            print("ughh (4)")
//            return nil
//        }

//        guard let viewControllerIndex = titles.index(of: a.title!) else {
//            print("\(a.title!) (6)")
//            return nil
//        }

        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! ScoutViewController) else {
            print("returning nil (1)")
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            //return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
//        switch viewControllerIndex {
//        case 0:
//            return nil
//        case 1:
//            return newVc(viewController: "View2")
//        default:
//            return nil
//        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let a = viewController as? AutoScoutViewController else{
//            print("ughh (3)")
//            return nil
//        }
//        guard let viewControllerIndex = titles.index(of: a.title!) else {
//            print("\(a.title!) (5)")
//            return nil
//        }
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! ScoutViewController) else {
            print("returning nil (1)")
            return nil
        }

        //print(viewControllerIndex)
        //print
        let nextIndex = viewControllerIndex + 1
        //print(nextIndex)

        let orderedViewControllersCount = orderedViewControllers.count

        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            //print("here1")

            //return orderedViewControllers.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
             return nil
        }

        guard orderedViewControllersCount > nextIndex else {
            //print("here2")
            return nil
        }
        //print(orderedViewControllers[nextIndex].title)
        return orderedViewControllers[nextIndex]
//        switch viewControllerIndex {
//        case 0:
//            return newVc(viewController: "AutoScout")
//        case 1:
//            return nil
//        default:
//            return nil
//        }
    }
    
    

    lazy var orderedViewControllers: [ScoutViewController] = {
        return [self.newVc(viewController: "AutoScout"),
                self.newVc(viewController: "TeleScout"),
                self.newVc(viewController: "PostMatchScout")]
    }()
    
    var titles = [
        "View2",
        "AutoScout"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            print(firstViewController.title!)
            //print(firstViewController.
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newVc(viewController: String) -> ScoutViewController {
        //if(viewController == "AutoScout"){
        //    return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: viewController) as! AutoScoutViewController
        //}
        let asvc: ScoutViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: viewController) as! ScoutViewController
        print(asvc)
        return asvc
    }
    
    func clearFields(){
//        for vc in orderedViewControllers {
//            vc.clearFields()
//        }
        
        
        ScoutViewController.crossedLine = false
        ScoutViewController.disabled = false
        ScoutViewController.climbed = false
       
       
        ScoutViewController.switchAutoCubes = 0
        ScoutViewController.scaleAutoCubes = 0
        ScoutViewController.switchTeleCubes = 0
        ScoutViewController.scaleTeleCubes = 0
        ScoutViewController.oppSwitchTeleCubes = 0
        ScoutViewController.vaultCubes = 0
        ScoutViewController.comments = ""
        

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Page View Controller")
        var viewControllers = self.tabBarController?.viewControllers
        viewControllers?.remove(at: 1)
        viewControllers?.insert(vc, at: 1)
        tabBarController?.setViewControllers(viewControllers, animated: true)
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
