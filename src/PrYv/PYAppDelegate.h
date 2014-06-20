//
//  PRYVAppDelegate.h
//  PrYv
//
//  Created by Victor Kristof on 21.01.13.
//  Copyright (c) 2013 PrYv. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PYLoginController, StatusMenuViewController, PYServicesController, User, AXStatusItemPopup;

@interface PYAppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate> {
@private
    PYServicesController *_servicesController;
}

@property BOOL connected;
@property BOOL loginWindowIsVisilbe;
@property (retain) PYLoginController *loginWindow;
@property (retain) StatusMenuViewController *statusMenuViewController;
@property (retain) AXStatusItemPopup *statusItemPopup;
@property (retain) User *user;


+ (PYAppDelegate*)sharedInstance;
- (void)loadUser;

@end
