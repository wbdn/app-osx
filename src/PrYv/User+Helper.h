//
//  Created by Konstantin Dorodov on 1/4/13.
//  Copyright (c) 2012 PrYv. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "User.h"

@class PYConnection;

@interface User (Helper)

// get the current user for the application
+(User *)currentUser;

+ (void)saveConnection:(PYConnection *)connection;

/**
 @name create or change the current user

 @discussion will reset the existing user with default values or create a new one if none exist.
 This method will set a default folder Id for the user associated to the OpenUDID value for this phone
 the folder id can be however anything you want but must be a unique Id you can remember.

 @param userIdentifier is the userID in the PrYv API
 @param token is the user Authorization token to connect to the PrYv API
 */



+(User*)createNewUserWithUsername:(NSString *)username
							AndToken:(NSString *)token;
-(NSString*)description;
-(void)logout;
//-(PYConnection*)connection;
-(NSArray*)sortLastPryvedEvents;
-(void)updateNumberOfPryvedEvents;

@end