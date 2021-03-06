//
//  PRYVLoginController.m
//  PrYv
//
//  Created by Victor Kristof on 30.01.13.
//  Copyright (c) 2013 PrYv. All rights reserved.
//

#import "PYLoginController.h"
#import "PYAppDelegate.h"
#import "Constants.h"

@interface PYLoginController () <PYWebLoginDelegate>

@end

@implementation PYLoginController

@synthesize user = _user;
@synthesize webView;

-(PYLoginController*)initForUser:(User*)user {
	self = [super initWithWindowNibName:@"LoginController"];
	if (self) {
		_user = user;
	}
	
	return self;
}

- (id)initWithWindow:(NSWindow *)window {
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    NSArray *objects = [NSArray arrayWithObjects:
                        kPYAPIConnectionRequestAllStreams,
                        kPYAPIConnectionRequestManageLevel,
                        nil];
    NSArray *keys = [NSArray arrayWithObjects:
                     kPYAPIConnectionRequestStreamId,
                     kPYAPIConnectionRequestLevel,
                     nil];
    NSArray *permissions = [NSArray arrayWithObject:[NSDictionary dictionaryWithObjects:objects forKeys:keys]];
    
    [PYWebLoginViewController requestConnectionWithAppId:@"pryv-integration-osx"
                                      andPermissions:permissions
                                            delegate:self
                                         withWebView:&webView];
}

- (void) pyWebLoginSuccess:(PYConnection*)pyConnection{
    
    NSLog(@"Signin With Success %@ %@",pyConnection.userID,pyConnection.accessToken);
    
    [User saveConnection:pyConnection];

    //Display notification
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"Login successful.";
    notification.informativeText = [NSString stringWithFormat:@"Welcome %@ !",pyConnection.userID];
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    
    
    [[PYAppDelegate sharedInstance] loadUser];
}

- (void) pyWebLoginAborted:(NSString*)reason {
    NSLog(@"Signin Aborded: %@",reason);
}

- (void) pyWebLoginError:(NSError*)error {
    NSLog(@"Signin Error: %@",error);
}

@end
