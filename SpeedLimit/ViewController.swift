//
//  ViewController.swift
//  SpeedLimit
//


import UIKit
import CoreLocation


class ViewController: UIViewController, OEEventsObserverDelegate {
   var locationManager: LocationManager!
   var currentSpeed : NSNumber = 0.0
   var speedLimit : Int = 0
   var yellowSpeed : Int = 0
   var redSpeed : Int = 5
   var currentLocation : CLLocation! = nil
   var viewFirstLoad : Bool = true
   
   /* Timers/Intervals */
   var speedUpdateTimer = NSTimer()
   var startTime : NSTimeInterval = 0
   var currentTime = NSDate.timeIntervalSinceReferenceDate()
   
   /* Variables for Speech Recognition */
   var speakAlert: Bool = true                        //toggle alerts on
   let openEarsEventsObserver = OEEventsObserver()
   var fliteContoroller = OEFliteController()
   var slt = Slt()                                    //voice
   var lmGenerator = OELanguageModelGenerator()
   var words = ["SPEED LIMIT", "NOT"]
   var name = "languageModelFiles"
   var lmPath: String?
   var dicPath: String?
   
   /*Label Variables*/
   @IBOutlet var outputLabel: UILabel! = nil          //current speed limit
   @IBOutlet var speedLimitLabel: UILabel! = nil      //"Speed Limit:"
   @IBOutlet weak var overTextView: UITextView!       //speeding warning
   
   @IBOutlet weak var navBar: UINavigationBar!
   
   override func viewDidLoad() {
      
      overTextView.hidden = true
      overTextView.text = "You are going more than \(redSpeed) miles over the speed limit. Please slow down."
      super.viewDidLoad()
      
      /* Makes Navigation bar translucent */
      navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
      navBar.shadowImage = UIImage()
      navBar.translucent = true
      /* End nav bar settings*/
      
      locationManager = LocationManager()
      outputLabel.font = UIFont.boldSystemFontOfSize(80.0)
      speedLimitLabel.font = UIFont.boldSystemFontOfSize(25)
      speedLimitLabel.text = "Speed Limit:"
      
      locationManager.checkLocationServices()

      speedUpdateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateSpeed"), userInfo: nil, repeats: true)
      
      if(viewFirstLoad){
         /* Speech Recognition setup */
         openEarsEventsObserver.delegate = self
         
         var err: NSError? = lmGenerator.generateLanguageModelFromArray(words, withFilesNamed: name, forAcousticModelAtPath: OEAcousticModel.pathToModel("AcousticModelEnglish"))
         
         if err == nil {
            lmPath = lmGenerator.pathToSuccessfullyGeneratedLanguageModelWithRequestedName(name)
            dicPath = lmGenerator.pathToSuccessfullyGeneratedDictionaryWithRequestedName(name)
         } else {
            println("Error: \(err!)")
         }
         
         OEPocketsphinxController.sharedInstance().setActive(true, error: nil)
         OEPocketsphinxController.sharedInstance().startListeningWithLanguageModelAtPath(lmPath, dictionaryAtPath: dicPath, acousticModelAtPath: OEAcousticModel.pathToModel("AcousticModelEnglish"), languageModelIsJSGF: false)
         /* End Speech Recognition Setup*/
      }
   }
   
   /* Updates the SpeedLimit and triggers backgrounds colors and alerts */
   func updateSpeed(){
      
      fetchSpeedLimitData()
      updateCurrentSpeed()
      
      
      if(speedLimit == 0){
         outputLabel.font = UIFont.boldSystemFontOfSize(25)
         outputLabel.text = "Unknown"
      }
      else if(currentSpeed.integerValue < speedLimit + yellowSpeed){
         outputLabel.text = "\(speedLimit)"
         overTextView.hidden = true
         self.view.backgroundColor = UIColor.whiteColor()
      }
      else if(currentSpeed.integerValue < speedLimit + redSpeed && currentSpeed.integerValue >= speedLimit + yellowSpeed){
         outputLabel.font = UIFont.boldSystemFontOfSize(80.0)
         outputLabel.text = "\(speedLimit)"
         overTextView.hidden = true
         self.view.backgroundColor = UIColor.yellowColor()
      }
      else{
         overTextView.hidden = false
         outputLabel.font = UIFont.boldSystemFontOfSize(80.0)
         outputLabel.text = "\(speedLimit)"
         self.view.backgroundColor = UIColor.redColor()
         if(startTime == 0 || calcElapsedTime()/60 > 5){
            startTime = NSDate.timeIntervalSinceReferenceDate()
            speakWarning()
         }
      }
   }
   
   
   /* Calculates time elapsed from last SpeakWarning() Alert */
   func calcElapsedTime() -> NSTimeInterval{
      var currentTime = NSDate.timeIntervalSinceReferenceDate()
      var elapsedTime: NSTimeInterval = currentTime - startTime
      return elapsedTime
   }
   
   /* Speaks an Alert if a speakWarning is set to true */
   func speakWarning(){
      if(speakAlert){
         fliteContoroller.say("You are going more than \(redSpeed) miles over the speed limit. Please slow down.", withVoice: slt)
      }
      
   }
   
   /* Fetches Speed Limit Data */
   func fetchSpeedLimitData(){
      
      var lat = locationManager.getCoord().latitude
      var long = locationManager.getCoord().longitude
      var found = false
      let dbPath = NSBundle.mainBundle().pathForResource("SpeedLimitDatabase", ofType:"sqlite3")
      let database = FMDatabase(path: dbPath)
      var direc: String = ""
      let numDirec = locationManager.getDirection()
      
      /* Determine direction travelled. */
      if(numDirec > 270 && numDirec < 90){
         direc = "N"
      }
      else{
         direc = "S"
      }
      
      /* Open and query the database file. */
      if(!database.open()){
         println("Unable to open database")
         return
      }
      
      if let rs = database.executeQuery("select * from SpeedLimits", withArgumentsInArray: nil){
         while(rs.next() && found == false){
            let latMax = rs.stringForColumn("latitudeMax") //hkEdits---------
            let longMax = rs.stringForColumn("longitudeMax")
            let latMin = rs.stringForColumn("latitudeMin")
            let longMin = rs.stringForColumn("longitudeMin")
            let direction = rs.stringForColumn("direction")
            let speedlimitString = rs.stringForColumn("speedlimit")
            
            let latitudeMax = (latMax as NSString).doubleValue
            let longitudeMax = (longMax as NSString).doubleValue
            let latitudeMin = (latMin as NSString).doubleValue
            let longitudeMin = (longMin as NSString).doubleValue
            let speedlimit = speedlimitString.toInt()
            
            if(lat > latitudeMin && long > longitudeMin && lat > latitudeMin && long > longitudeMin && direc == direction){//hkedits-------
               speedLimit = speedlimit!
               found == true
            }
         }
      } else {
         println("executeQuery failed: \(database.lastErrorMessage())")
      }
      
      database.close()
   }
   
   /* Updates the Current Speed */
   func updateCurrentSpeed(){
      currentSpeed = locationManager.getSpeed()
   }
   
   /* Settings Button Segue - Passes variables to settings view */
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      if segue.identifier == "settingsSegue"{
         if let settingsView = segue.destinationViewController as? SettingsViewController{
            settingsView.setToggle = speakAlert
            settingsView.redText = String(redSpeed)
            settingsView.yellowText = String(yellowSpeed)
            settingsView.settingsStartTime = startTime
         }
         
      }
   }
   
   /* Main View Primary Button - Speaks Speed Limit */
   @IBAction func speedLimitButton(sender: UIButton) {
      
      fliteContoroller.say("The current speed limit is \(speedLimit)", withVoice: slt)
      
   }
   
   
   /* Speech Recognition -
      CODE FROM :https://gist.github.com/allenjwong/b962972d64904d2217bc
   */
   func pocketsphinxDidReceiveHypothesis(hypothesis: String!, recognitionScore: String!, utteranceID: String!) {
      
      /* Start: Our Code */
      if (hypothesis == "SPEED LIMIT"){
         fliteContoroller.say("The current speed limit is \(speedLimit)", withVoice: slt)
      }
      /* End: Our Code */
      
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
   /* End Speech Recognition Code*/
}

