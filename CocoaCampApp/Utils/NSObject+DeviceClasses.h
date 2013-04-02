//
//  NSObject+DeviceClasses.h
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 01.04.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DeviceClasses)

/**
 Returns device specific subclass.
 In order to avoid putting random if( device == iPhone/iPad) statements in controllers, view etc,
 deviceAlloc decide at runtime whether there is a subclass of particular class for iPad/iPhone.
 It check whether class with "Pad" (for iPad) or "Phone" (for iPhone) prefix in name is loaded.
 If yes, it allocates instance of it. If no, it loads default instance of the class.
 */
+ (id)deviceAlloc;

@end
