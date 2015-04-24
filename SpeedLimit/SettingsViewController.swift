//
//  settingsViewController.swift
//  SpeedLimit
//

import UIKit

class SettingsViewController: UIViewController {
   
   /* Default values/reset time interval from main view */
   var setToggle : Bool = true
   var redText : String = "0"
   var yellowText : String = "5"
   var settingsStartTime : NSTimeInterval = 0
   
   /* Text Entry/Toggle declaration */
   @IBOutlet weak var voiceToggle: UISwitch!
   @IBOutlet weak var redSettingsSpeed: UITextField!
   @IBOutlet weak var yellowSettingsSpeed: UITextField!
   
   /* Sets text/toggle to default values */
   override func viewDidLoad() {
      super.viewDidLoad()
      
      voiceToggle.on = setToggle
      redSettingsSpeed.text = redText
      yellowSettingsSpeed.text = yellowText
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   /* Segue carries values from this view to the main view. */
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      if segue.identifier == "mainSegue"{
         if let mainView = segue.destinationViewController as? ViewController{
            let tempYellow: Int? = yellowSettingsSpeed.text.toInt()
            let tempRed: Int? = redSettingsSpeed.text.toInt()
            
            if(tempYellow! < tempRed!){
               mainView.yellowSpeed = tempYellow!
               mainView.redSpeed = tempRed!
               mainView.speakAlert = voiceToggle.on
               mainView.startTime = settingsStartTime
               mainView.viewFirstLoad = false
            }
            

         }
   
      }
   }
  
}

