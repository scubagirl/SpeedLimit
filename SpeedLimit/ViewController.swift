//
//  ViewController.swift
//  SpeedLimit
//
//  Created by Lauren C. O'Keefe on 3/17/15.
//  Copyright (c) 2015 ScubaGirl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


   var currentSpeed : Int = 0
   @IBOutlet var outputLabel: UILabel! = nil
   
   
   override func viewDidLoad() {
      
      super.viewDidLoad()
      
      outputLabel.font = UIFont.boldSystemFontOfSize(60.0)
      outputLabel.text = "\(currentSpeed)"
      
   }
   

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


   
   @IBAction func settingsButton(sender: UIButton) {
      
      outputLabel.text = "Settings"
      outputLabel.font = UIFont.boldSystemFontOfSize(20.0)
      self.view.backgroundColor = UIColor.whiteColor()
      
   }

   @IBAction func speedLimitButtion(sender: UIButton) {
      currentSpeed = 15
      outputLabel.font = UIFont.boldSystemFontOfSize(60.0)
      outputLabel.text = "\(currentSpeed)"
      self.view.backgroundColor = UIColor.redColor()
      
   }
   

}

