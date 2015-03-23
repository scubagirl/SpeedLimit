//
//  ViewController.swift
//  SpeedLimit
//
//  Created by Lauren C. O'Keefe on 3/17/15.
//  Copyright (c) 2015 ScubaGirl. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{

   var locationManager: LocationManager!
   var currentSpeed : NSNumber = 0.0
   var speedLimit : Int = 0
   var currentLocation: CLLocation! = nil
   @IBOutlet var outputLabel: UILabel! = nil
   
   @IBOutlet var speedLimitLabel: UILabel! = nil
   
   override func viewDidLoad() {
      
      super.viewDidLoad()
      locationManager = LocationManager()
      outputLabel.font = UIFont.boldSystemFontOfSize(60.0)
      speedLimitLabel.font = UIFont.boldSystemFontOfSize(30.0)
      speedLimitLabel.text = "Speed Limit:"
      locationManager.checkLocationServices()
   }
   
   

   @IBAction func settingsButton(sender: AnyObject) {
      
      let settingsView = self.storyboard?.instantiateViewControllerWithIdentifier("settingsView") as settingsViewController
      self.navigationController?.pushViewController(settingsView, animated: true)
      
   }

   @IBAction func speedLimitButtion(sender: UIButton) {
      speedLimit = 0
      currentSpeed = locationManager.getSpeed()
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
   

}

