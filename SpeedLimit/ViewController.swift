//
//  ViewController.swift
//  SpeedLimit
//


import UIKit
import CoreLocation

class ViewController: UIViewController{

   var locationManager: LocationManager!
   var currentSpeed : NSNumber = 0.0
   var speedLimit : Int = 0
   var currentLocation: CLLocation! = nil
   @IBOutlet var outputLabel: UILabel! = nil
   var timer = NSTimer()
   
   @IBOutlet var speedLimitLabel: UILabel! = nil
   
   override func viewDidLoad() {
      
      super.viewDidLoad()
      locationManager = LocationManager()
      outputLabel.font = UIFont.boldSystemFontOfSize(60.0)
      speedLimitLabel.font = UIFont.boldSystemFontOfSize(30.0)
      speedLimitLabel.text = "Speed Limit:"
      locationManager.checkLocationServices()
      timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateSpeed"), userInfo: nil, repeats: true)
   }
   
   //need to change to get the speed limit from the database instead and compare to current speed
   func updateSpeed(){
      
      let direction = locationManager.getDirection()
      fetchSpeedLimitData(direction)
      updateCurrentSpeed()
      
      //temporary
      currentSpeed = Int(arc4random_uniform(50))
      speedLimit = 30
      //end temporary
      
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
   
   func fetchSpeedLimitData(direction: CLLocationDirection){
      direction      //use this to fetch the correct infor from the DB
      
      speedLimit = 0
   }
   
   func updateCurrentSpeed(){
      currentSpeed = locationManager.getSpeed()
   }
   

   @IBAction func settingsButton(sender: AnyObject) {
      
      let settingsView = self.storyboard?.instantiateViewControllerWithIdentifier("settingsView") as settingsViewController
      self.navigationController?.pushViewController(settingsView, animated: true)
      
   }

   @IBAction func speedLimitButton(sender: UIButton) {
      
      //Implement push to read text
      
   }
   

}

