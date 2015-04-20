//
//  settingsViewController.swift
//  SpeedLimit
//

import UIKit

class SettingsViewController: UIViewController {
   
   var setToggle : Bool = true
   var redText : String = "0"
   var yellowText : String = "5"
   var settingsStartTime : NSTimeInterval = 0
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      voiceToggle.on = setToggle
      redSettingsSpeed.text = redText
      yellowSettingsSpeed.text = yellowText
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      if segue.identifier == "mainSegue"{
         if let mainView = segue.destinationViewController as? ViewController{
            let tempYellow: Int? = yellowSettingsSpeed.text.toInt()
            let tempRed: Int? = redSettingsSpeed.text.toInt()
            
            mainView.yellowSpeed = tempYellow!
            mainView.redSpeed = tempRed!
            mainView.speakAlert = voiceToggle.on
            mainView.startTime = settingsStartTime
            mainView.viewFirstLoad = false

         }
   
      }
   }
   
   @IBOutlet weak var voiceToggle: UISwitch!
   @IBOutlet weak var redSettingsSpeed: UITextField!
   @IBOutlet weak var yellowSettingsSpeed: UITextField!

   
   
}

