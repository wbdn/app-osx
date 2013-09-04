//
//  NSMutableArray+Helper.m
//  osx-integration
//
//  Created by Victor Kristof on 03.09.13.
//  Copyright (c) 2013 PrYv. All rights reserved.
//

#import "NSMutableArray+Helper.h"
#import "File.h"

@implementation NSMutableArray (Helper)

- (BOOL)areAllImages
{
    for (File *f in self) {
        NSLog(@"BOOL value : %c",[f.isPicture boolValue]);
        if (![f.isPicture boolValue]) {
            NSLog(@"Not a picture");
            return NO;
        }
    }
    return YES;
}

@end
