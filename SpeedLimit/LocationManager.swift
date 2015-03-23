//
//  LocationManager.swift
//  SpeedLimit
//
//  Created by Lauren C. O'Keefe on 3/19/15.
//  Copyright (c) 2015 ScubaGirl. All rights reserved.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate {
   
   var manager: CLLocationManager!
   
   
   override init(){
      super.init()
      manager = CLLocationManager()
      manager.desiredAccuracy = kCLLocationAccuracyBest
      manager.distanceFilter = 10.0
      manager.activityType = .AutomotiveNavigation
      manager.delegate = self
   }
   
   func startUpdatingLocation() {
      
      manager.delegate = self;
      
      manager.startUpdatingLocation()
   }
   
   func checkLocationServices() {
      switch CLLocationManager.authorizationStatus() {
         
      case .AuthorizedAlways, .AuthorizedWhenInUse /*, .Authorized */:
         
         startUpdatingLocation()
         
      default:
         
         manager.delegate = self
         manager.requestAlwaysAuthorization()
         startUpdatingLocation()
      }
   }
   
   func getSpeed() ->NSNumber {
      return manager.location.speed
   }
   
   func getCoord() ->CLLocationCoordinate2D {
      return manager.location.coordinate
   }
}
