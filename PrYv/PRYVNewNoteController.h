//
//  PRYVNewNoteController.h
//  PrYv
//
//  Created by Victor Kristof on 29.01.13.
//  Copyright (c) 2013 PrYv. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PRYVNewNoteController : NSWindowController{
@private
	IBOutlet NSTextField *title;
	IBOutlet NSTextField *content;
	IBOutlet NSTokenField *tags;
	IBOutlet NSTextField *folder;
}
-(IBAction)createNote:(id)sender;
@end
