//
//  ViewController.swift
//  SpeedLimit
//
//  Created by Lauren C. O'Keefe on 3/17/15.
//  Copyright (c) 2015 ScubaGirl. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
   
//   let locationManager = CLLocationManager()
   var locationManager:CLLocationManager!
   var currentSpeed : NSNumber = 0.0
   var speedLimit : Int = 0
   @IBOutlet var outputLabel: UILabel! = nil
   
   @IBOutlet var speedLimitLabel: UILabel! = nil
   
   override func viewDidLoad() {
      
      super.viewDidLoad()
      outputLabel.font = UIFont.boldSystemFontOfSize(60.0)
      outputLabel.text = "\(currentSpeed)"
      speedLimitLabel.font = UIFont.boldSystemFontOfSize(30.0)
      speedLimitLabel.text = "Speed Limit:"
      
      locationManager = CLLocationManager()
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestAlwaysAuthorization()
      locationManager.startUpdatingLocation()
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   
   func getLocation() -> CLLocationCoordinate2D {

      return locationManager.location.coordinate
   }
   
   func getSpeed() -> NSNumber {
      
      return locationManager.location.speed
      
   }
   

   @IBAction func settingsButton(sender: AnyObject) {
      
      let settingsView = self.storyboard?.instantiateViewControllerWithIdentifier("settingsView") as settingsViewController
      self.navigationController?.pushViewController(settingsView, animated: true)
      
   }

   @IBAction func speedLimitButtion(sender: UIButton) {
      getLocation()
      speedLimit = 0
      outputLabel.font = UIFont.boldSystemFontOfSize(60.0)
      outputLabel.text = "\(speedLimit)"
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

