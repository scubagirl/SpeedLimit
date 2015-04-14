//
//  ViewController.h
//  Speech Recognition
//
//  Created by Jackie Gonzales on 4/8/15.
//  Copyright (c) 2015 Jackie Hey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Slt/Slt.h>
#import <OpenEars/OEFliteController.h>
#import <OpenEars/OEEventsObserver.h>


@interface ViewController : UIViewController <OEEventsObserverDelegate>

@property (strong, nonatomic) OEEventsObserver *openEarsEventsObserver;
@property (strong, nonatomic) OEFliteController *fliteController;
@property (strong, nonatomic) Slt *slt;

@end

