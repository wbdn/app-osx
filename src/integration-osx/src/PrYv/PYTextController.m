//
//  PRYVTextController.m
//  PrYv
//
//  Created by Victor Kristof on 03.04.13.
//  Copyright (c) 2013 PrYv. All rights reserved.
//

#import "PYTextController.h"
#import "PYAppDelegate.h"
#import "User.h"
#import "User+Helper.h"
#import "PryvedEvent.h"
#import "Constants.h"

@implementation PYTextController

-(void)pryvText:(NSString *)text inStreamId:(NSString *)streamId withTags:(NSArray *)tags{
    if ([text isEqualToString:@""]) {
		NSLog(@"No text entered !");
	}else {
        //Get the general context
		User *user = [User currentUser];
        
        PYEvent *event = [[PYEvent alloc] init];
        event.streamId = [NSString stringWithString:streamId];
        [event setEventDate:[NSDate date]];
        event.type = @"note/txt";
        event.eventContent = [NSString stringWithString:text];
        event.tags = [NSArray arrayWithArray:tags];
        
        [[user connection] eventCreate:event successHandler:^(NSString *newEventId, NSString *stoppedId, PYEvent *event) {
            NSLog(@"Pryved text with event ID : %@", newEventId);
            
            //Display notification
            NSUserNotification *notification = [[NSUserNotification alloc] init];
            notification.title = @"Text pryved successfully !";
            notification.informativeText = [NSString stringWithFormat:@"Your text \"%@\" has been pryved.",event.eventContent];
            [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
            
            //Add text event to list of last synced events
           
            /* X2
            PryvedEvent *pryvedEvent = [NSEntityDescription insertNewObjectForEntityForName:@"PryvedEvent"
                                                                     inManagedObjectContext:context];
             
            NSDate *currentDate = [NSDate date];
            pryvedEvent.date = currentDate;
            pryvedEvent.eventId = [NSString stringWithString:newEventId];
            pryvedEvent.type = [NSString stringWithString:kPYLastPryvedEventText];
            pryvedEvent.content = [NSString stringWithString:text];
            
            [user addPryvedEventsObject:pryvedEvent];
            [context save:nil];
             */
        } errorHandler:^(NSError *error) {
            NSLog(@"Error while pryving text : %@", error);
            //Display notification
            NSUserNotification *notification = [[NSUserNotification alloc] init];
            notification.title = @"Problem while pryving text.";
            notification.informativeText = [NSString stringWithFormat:@"%@",[[error userInfo] valueForKey:NSLocalizedDescriptionKey]];
            [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];

        }];
        
    }
}

@end
