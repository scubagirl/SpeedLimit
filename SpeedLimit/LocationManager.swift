//
//  LocationManager.swift
//  SpeedLimit
//


import Foundation
import CoreLocation

/* Class for determining location */
class LocationManager: NSObject, CLLocationManagerDelegate {
   
   var manager: CLLocationManager!
   
   /* Initiallize CLLocationManager*/
   override init(){
      super.init()
      manager = CLLocationManager()
      manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
      manager.distanceFilter = 10.0 
      manager.activityType = .AutomotiveNavigation
      manager.delegate = self
   }
   
   /* Start ability of updating of location */
   func startUpdatingLocation() {
      
      manager.delegate = self;
      manager.startUpdatingLocation()
      
   }
   
   /* Authorize the app to use location services */
   func checkLocationServices() {
      switch CLLocationManager.authorizationStatus() {
         
      case .AuthorizedAlways, .AuthorizedWhenInUse:
         
         startUpdatingLocation()
         
      default:
         
         manager.delegate = self
         manager.requestAlwaysAuthorization()
         startUpdatingLocation()
      }
   }
   
   func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]!) {
      println("locations = \(locations)")
//      NSThread.sleepForTimeInterval(0.001)
   }
   
   /* Get speed - return -1 if location not available */
   func getSpeed() ->NSNumber {
      if (manager.location != nil){
         return manager.location.speed * 2.23694
      }
      return -1
   }
   
   /* Get direction - return -1 if location not available */
   func getDirection() ->CLLocationDirection {
      if(manager.location != nil){
         return manager.location.course
      }
      return -1
   }
   
   /* Get coordinates - return invalid (lat = -180, long = -180) if location not available */
   func getCoord() ->CLLocationCoordinate2D {
      if(manager.location != nil){
         return manager.location.coordinate
      }
      
      return kCLLocationCoordinate2DInvalid
   }
}
