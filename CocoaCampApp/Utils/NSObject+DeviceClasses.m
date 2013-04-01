//
//  NSObject+DeviceClasses.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 01.04.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "NSObject+DeviceClasses.h"

@implementation NSObject (DeviceClasses)

+ (Class)deviceSpecificSubclassOf:(Class)parentClass
{
    UIUserInterfaceIdiom currentDevice = [UIDevice currentDevice].userInterfaceIdiom;
    NSString *parentClassName = NSStringFromClass(parentClass);
    NSMutableString *deviceClassName = [[NSMutableString alloc] initWithString:parentClassName];
    
    if (currentDevice == UIUserInterfaceIdiomPad) {
        [deviceClassName insertString:@"Pad" atIndex:2];
    }
    else if (currentDevice == UIUserInterfaceIdiomPhone) {
        [deviceClassName insertString:@"Phone" atIndex:2];
    }
    
    return NSClassFromString(deviceClassName);
}

+ (id)deviceAlloc
{
    Class deviceClass = [self deviceSpecificSubclassOf:self];
    
    if (deviceClass != nil) {
        return [deviceClass allocWithZone:nil];
        return [deviceClass alloc];
    }
    else {
        return [self allocWithZone:nil];
        return [self alloc];
    }
}

@end
