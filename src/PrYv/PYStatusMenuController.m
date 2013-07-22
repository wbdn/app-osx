//
//  PRYVMenuController.m
//  PrYv
//
//  Created by Victor Kristof on 29.01.13.
//  Copyright (c) 2013 PrYv. All rights reserved.
//

#import "PYStatusMenuController.h"
#import "PYNewNoteController.h"
#import "PYAppDelegate.h"
#import "User+Helper.h"
#import "User.h"
#import "NoteEvent.h"
#import "PYFileController.h"
#import "DragAndDropStatusMenuView.h"
#import "PYLoginController.h"
#import "Constants.h"

@implementation PYStatusMenuController

-(PYStatusMenuController*)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

-(void) awakeFromNib {
	NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
	_statusItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
	[_statusItem retain];
	DragAndDropStatusMenuView *dragAndDropView = [[DragAndDropStatusMenuView alloc]
												  initWithFrame:NSMakeRect(0, 0, 22, 22)];
	dragAndDropView.statusItem = _statusItem;
	[dragAndDropView setMenu:_statusMenu];
	[_statusItem setView:dragAndDropView];
	[dragAndDropView release];
    [newNote setEnabled:NO];
    [pryvFiles setEnabled:NO];
    [displayCurrentUser setEnabled:NO];
    [purgeEvents setEnabled:NO];
    [goToMyPryv setEnabled:NO];
    [preferences setEnabled:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateMenuItemsLogin:)
                                                 name:PYLoginSuccessfullNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateMenuItemsLogout:)
                                                 name:PYLogoutSuccessfullNotification
                                               object:nil];
}

-(void)showMenu {
	[_statusItem popUpStatusItemMenu:_statusMenu];
}

-(void)updateMenuItemsLogin:(NSNotification*)notification{
    [logInOrOut setTitle:@"Log out"];
}

-(void)updateMenuItemsLogout:(NSNotification*)notification{
    [logInOrOut setTitle:@"Log in"];
}

-(IBAction)openFiles:(id)sender {
	NSOpenPanel *openDialog = [NSOpenPanel openPanel];
	[openDialog retain]; //Mac OS X 10.6 fix	
	_fileController = [[PYFileController alloc] initWithOpenPanel:openDialog];
	[_fileController runDialog];
}

-(IBAction)displayCurrentUser:(id)sender {
	NSManagedObjectContext *context = [[PYAppDelegate sharedInstance] managedObjectContext];
	User *current = [User currentUserInContext:context];
	NSLog(@"\n%@",[current description]);
}

-(IBAction)purgeEvents:(id)sender {
	NSManagedObjectContext *context = [[PYAppDelegate sharedInstance] managedObjectContext];
	User *current = [User currentUserInContext:context];
	[current purgeEventsInContext:context];
}

- (IBAction)logInOrOut:(id)sender {
    NSManagedObjectContext *context = [[PYAppDelegate sharedInstance] managedObjectContext];
    User * user = [User currentUserInContext:context];
	//If no user has been found, open login window
	if (!user) {
		loginWindow = [[PYLoginController alloc] initForUser:user];
		[loginWindow.window setDelegate:self];
		[loginWindow showWindow:self];
        
        //If the user has been found
	}else {
		[user logoutFromContext:context];
    }
}

-(void)windowDidBecomeKey:(NSNotification *)notification{
    if ([[[notification object] identifier] isEqual: @"LoginWindow"]) {
        [logInOrOut setEnabled:NO];
    }
}

-(void)windowWillClose:(NSNotification *)notification{
   if ([[[notification object] identifier] isEqual: @"LoginWindow"]) {
       [logInOrOut setEnabled:YES];
   }
}


-(IBAction)newNote:(id)sender {
	if(!_newNoteController) {
		_newNoteController = [[PYNewNoteController alloc] initWithWindowNibName:@"NewNote"];
		[_newNoteController.window setDelegate:_newNoteController];
	}
	[_newNoteController showWindow:self];
}

-(IBAction)goToMyPryv:(id)sender {
	NSURL *url = [NSURL URLWithString:@"http://www.pryv.net/"];
	if(![[NSWorkspace sharedWorkspace] openURL:url])
		NSLog(@"Failed to open url: %@",[url description]);
}

-(void)dealloc {
	[_newNoteController release];
	[_fileController release];
	[_statusItem release];
	[super dealloc];
}

@end