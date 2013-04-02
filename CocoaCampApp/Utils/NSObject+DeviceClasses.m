//
//  NSObject+DeviceClasses.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 01.04.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "NSObject+DeviceClasses.h"

#define CLASSES_PREFIX  @"MS"

@implementation NSObject (DeviceClasses)

#pragma mark - + NSObject (DeviceClasses)

+ (Class)_deviceSpecificSubclassOf:(Class)parentClass
{
    UIUserInterfaceIdiom currentDevice = [UIDevice currentDevice].userInterfaceIdiom;
    NSString *parentClassName = NSStringFromClass(parentClass);
    NSMutableString *deviceClassName = [[NSMutableString alloc] initWithString:parentClassName];
    
    if (currentDevice == UIUserInterfaceIdiomPad) {
        [deviceClassName insertString:@"Pad" atIndex:[CLASSES_PREFIX length]];
    }
    else if (currentDevice == UIUserInterfaceIdiomPhone) {
        [deviceClassName insertString:@"Phone" atIndex:[CLASSES_PREFIX length]];
    }
    
    return NSClassFromString(deviceClassName);
}

+ (id)deviceAlloc
{
    Class deviceClass = [self _deviceSpecificSubclassOf:self];
    
    if (deviceClass != nil) {
        return [deviceClass allocWithZone:nil];
    }
    else {
        return [self allocWithZone:nil];
    }
}

@end
