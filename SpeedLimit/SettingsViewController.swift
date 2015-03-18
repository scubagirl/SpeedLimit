//
//  settingsViewController.swift
//  SpeedLimit
//
//  Created by Lauren C. O'Keefe on 3/18/15.
//  Copyright (c) 2015 ScubaGirl. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   @IBAction func backButton(sender: AnyObject) {
      
      self.navigationController?.popToRootViewControllerAnimated(true)
   }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
