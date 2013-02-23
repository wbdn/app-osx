//
//  PRYVLoginController.h
//  PrYv
//
//  Created by Victor Kristof on 30.01.13.
//  Copyright (c) 2013 PrYv. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "User+Helper.h"
#import "User.h"

@interface PRYVLoginController : NSWindowController{ 
@private
    IBOutlet NSTextField *_username;
    IBOutlet NSTextField *_oAuthToken;
    User *_user;
}

-(PRYVLoginController*)initForUser:(User*)user;
-(IBAction)login:(id)sender;

@end
