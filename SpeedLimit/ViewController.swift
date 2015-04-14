//
//  ViewController.swift
//  SpeedLimit
//


import UIKit
import CoreLocation
import AVFoundation
//import SQLite


class ViewController: UIViewController, OEEventsObserverDelegate {
   
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
   
   //vars for speech recognition
   var lmPath: String!
   var dicPath: String!
   var words: Array<String> = ["SPEED LIMIT", "SPEED"]
   var currentWord: String!
   let openEarsEventsObserver = OEEventsObserver()
   var fliteContoroller = OEFliteController()
   var slt = Slt()
   
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
      
      
      
      openEarsEventsObserver.delegate = self
      
      var lmGenerator = OELanguageModelGenerator()
      var words = ["SPEED LIMIT", "NOT"]
      
      
      var name = "languageModelFiles"
      var err: NSError? = lmGenerator.generateLanguageModelFromArray(words, withFilesNamed: name, forAcousticModelAtPath: OEAcousticModel.pathToModel("AcousticModelEnglish"))
      
      var lmPath: String?
      
      var dicPath: String?
      
      if err == nil {
         lmPath = lmGenerator.pathToSuccessfullyGeneratedLanguageModelWithRequestedName(name)
         dicPath = lmGenerator.pathToSuccessfullyGeneratedDictionaryWithRequestedName(name)
      } else {
         println("Error: \(err!)")
      }
      
      OEPocketsphinxController.sharedInstance().setActive(true, error: nil)
      OEPocketsphinxController.sharedInstance().startListeningWithLanguageModelAtPath(lmPath, dictionaryAtPath: dicPath, acousticModelAtPath: OEAcousticModel.pathToModel("AcousticModelEnglish"), languageModelIsJSGF: false)
      
      
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
      
      let settingsView = self.storyboard?.instantiateViewControllerWithIdentifier("settingsView") as! settingsViewController
      self.navigationController?.pushViewController(settingsView, animated: true)
      
   }
   
   @IBAction func speedLimitButton(sender: UIButton) {
      
      fliteContoroller.say("The current speed limit is \(speedLimit)", withVoice: slt)
      
   }
   
   
   /*Speech Recognition - 
      CODE FROM :https://gist.github.com/allenjwong/b962972d64904d2217bc
   */
   func pocketsphinxDidReceiveHypothesis(hypothesis: String!, recognitionScore: String!, utteranceID: String!) {
      
      //Start: Our Code
      if (hypothesis == "SPEED LIMIT"){
         fliteContoroller.say("The current speed limit is \(speedLimit)", withVoice: slt)
      }
      //End: Our Code
      println("The received hypothesis is \(hypothesis) with a score of \(recognitionScore) and an ID of \(utteranceID)")
   }
   
   func pocketsphinxDidStartListening() {
      println("Pocketsphinx is now listening.")
   }
   
   func pocketsphinxDidDetectSpeech() {
      println("Pocketsphinx has detected speech.")
   }
   
   func pocketsphinxDidDetectFinishedSpeech() {
      println("Pocketsphinx has detected a period of silence, concluding an utterance.")
   }
   
   func pocketsphinxDidStopListening() {
      println("Pocketsphinx has stopped listening.")
   }
   
   func pocketsphinxDidSuspendRecognition() {
      println("Pocketsphinx has suspended recognition.")
   }
   
   func pocketsphinxDidResumeRecognition() {
      println("Pocketsphinx has resumed recognition.")
   }
   
   func pocketsphinxDidChangeLanguageModelToFile(newLanguageModelPathAsString: String!, andDictionary newDictionaryPathAsString: String!) {
      println("Pocketsphinx is now using the following language model: \(newLanguageModelPathAsString) and the following dictionary: \(newDictionaryPathAsString)")
   }
   
   func pocketSphinxContinuousSetupDidFailWithReason(reasonForFailure: String!) {
      println("Listening setup wasn't successful and returned the failure reason: \(reasonForFailure)")
   }
   
   func pocketSphinxContinuousTeardownDidFailWithReason(reasonForFailure: String!) {
      println("Listening teardown wasn't successful and returned the failure reason: \(reasonForFailure)")
   }
   
   func testRecognitionCompleted() {
      println("A test file that was submitted for recognition is now complete.")
   }
}

