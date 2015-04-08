//
//  ViewController.swift
//  SpeedLimit
//


import UIKit
import CoreLocation
import AVFoundation
import SQLite


class ViewController: UIViewController{
   
   let synth = AVSpeechSynthesizer()
   
   var locationManager: LocationManager!
   var currentSpeed : NSNumber = 0.0
   var speedLimit : Int = 0
   var yellowSpeed : Int = 0
   var redSpeed : Int = 5
   var currentLocation: CLLocation! = nil
   @IBOutlet var outputLabel: UILabel! = nil
   var timer = NSTimer()
   var speedTimer = NSTimer()
   var myUtterance = AVSpeechUtterance(string:"")
   var alreadySpeeding: Bool = false
   
   @IBOutlet var speedLimitLabel: UILabel! = nil
   
   @IBOutlet weak var overTextView: UITextView!
   
//   
//      let db = Database("\(dbPath)/db.sqlite3")
//   
//      let speedlimit_table = db["SpeedLimits"]
//      let latitude = Expression<Double>("latitude")
//      let longitude = Expression<Double>("longitude")
//      let direction = Expression<Int>("direction")
//      let speedlimit_db = Expression<String?>("speedlimit")
   

   
   override func viewDidLoad() {
      
      overTextView.hidden = true
      super.viewDidLoad()
      locationManager = LocationManager()
      outputLabel.font = UIFont.boldSystemFontOfSize(60.0)
      speedLimitLabel.font = UIFont.boldSystemFontOfSize(30.0)
      speedLimitLabel.text = "Speed Limit:"
      locationManager.checkLocationServices()
      timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateSpeed"), userInfo: nil, repeats: true)
      speedTimer = NSTimer.scheduledTimerWithTimeInterval(300, target:self, selector: Selector("speakWarning"), userInfo: nil, repeats: true)
   }
   
   //need to change to get the speed limit from the database instead and compare to current speed
   func updateSpeed(){
      
      fetchSpeedLimitData()
      updateCurrentSpeed()
      
      //temporary
      currentSpeed = 50
      speedLimit = 30
      //end temporary
      
      outputLabel.font = UIFont.boldSystemFontOfSize(60.0)
      outputLabel.text = "\(speedLimit)"
      
      if(currentSpeed.integerValue < speedLimit + yellowSpeed){
         overTextView.hidden = true
         self.view.backgroundColor = UIColor.whiteColor()
         alreadySpeeding = false
      }
      else if(currentSpeed.integerValue < speedLimit + redSpeed && currentSpeed.integerValue >= speedLimit + yellowSpeed){
         overTextView.hidden = true
         self.view.backgroundColor = UIColor.yellowColor()
      }
      else{
         overTextView.hidden = false
         alreadySpeeding = true
         self.view.backgroundColor = UIColor.redColor()
         if(alreadySpeeding == false){
            myUtterance = AVSpeechUtterance(string: overTextView.text)
            myUtterance.rate = 0.1
            synth.speakUtterance(myUtterance)
         }
      }
   }
   
   func speakWarning(){
      
   }
   
   func fetchSpeedLimitData(){
      let direc = locationManager.getDirection()
      var lat = locationManager.getCoord().latitude
      var long = locationManager.getCoord().longitude
      
      
      
      //      let latitude = Expression<Double>("latitude")
      //      let longitude = Expression<Double>("longitude")
      //      let direction = Expression<Int>("direction")
      //      let speedlimit_db = Expression<String?>("speedlimit")

      
      //      let query = db.speedlimit_table.select(speedlimit_db)	//SELECT "speedlimit" FROM "SpeedLimits"
      //         .filter(latitude == lat.doubleValue && longitude == long.doubleValue && direction == direc.integerValue) //WHERE (latitude = lat && longitude = long && direction = direc)
      //assuming variables work like this and && = AND
      
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

