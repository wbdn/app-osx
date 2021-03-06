//
//  PRYVMenuController.h
//  PrYv
//
//  Created by Victor Kristof on 29.01.13.
//  Copyright (c) 2013 PrYv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PYNewNoteController, PYFileController, PYLoginController, PYPreferencesPaneController, DragAndDropStatusMenuView;

@interface PYStatusMenuController : NSViewController <NSWindowDelegate, NSMenuDelegate>{
@private
	PYNewNoteController *_newNoteController;
	PYFileController *_fileController;
    PYLoginController *_loginWindow;
    PYPreferencesPaneController *_preferencesController;
	//NSStatusItem *_statusItem;
	IBOutlet NSMenu *_statusMenu;
    IBOutlet NSMenuItem *logInOrOut;
    IBOutlet NSMenuItem *newNote;
    IBOutlet NSMenuItem *pryvFiles;
    IBOutlet NSMenuItem *goToMyPryv;
    IBOutlet NSMenuItem *preferences;
    IBOutlet NSMenuItem *lastPryvedItems;
}

@property (retain,nonatomic) NSStatusItem *statusItem;;


-(PYStatusMenuController*)init;
-(IBAction)newNote:(id)sender;
-(IBAction)goToMyPryv:(id)sender;
-(IBAction)openFiles:(id)sender;
-(IBAction)logInOrOut:(id)sender;
-(void)showMenu;
-(void)updateMenuItemsLogin:(NSNotification*)notification;
-(void)updateMenuItemsLogout:(NSNotification*)notification;
-(void)updateLastPryvedEvents;
@end

