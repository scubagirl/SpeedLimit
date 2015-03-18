//
//  ViewController.swift
//  SpeedLimit
//
//  Created by Lauren C. O'Keefe on 3/17/15.
//  Copyright (c) 2015 ScubaGirl. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
   
   var location = CLLocation()
   var currentSpeed : NSNumber = 0.0
   var speedLimit : Int = 0
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
   
   func currentLocation(){
      currentSpeed = location.speed
      speedLimit = Int(rand())
      outputLabel.font = UIFont.boldSystemFontOfSize(60.0)
      outputLabel.text = "\(currentSpeed)"
      if(currentSpeed.integerValue <= speedLimit){
         self.view.backgroundColor = UIColor.whiteColor()
      }
      else if(currentSpeed.integerValue <= speedLimit + 5){
         self.view.backgroundColor = UIColor.yellowColor()
      }
      else{
         self.view.backgroundColor = UIColor.redColor()
      }
   }
   
   
   @IBAction func settingsButton(sender: UIButton) {
      
      outputLabel.text = "Settings"
      outputLabel.font = UIFont.boldSystemFontOfSize(20.0)
      self.view.backgroundColor = UIColor.whiteColor()
      
   }

   @IBAction func speedLimitButtion(sender: UIButton) {
      currentLocation()
      
      
   }
   

}

