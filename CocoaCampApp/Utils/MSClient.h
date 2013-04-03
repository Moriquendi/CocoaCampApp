//
//  MSClient.h
//  CocoaCampApp
//
//  Created by Michal Smialko on 03.04.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSClient : NSObject

+ (instancetype)sharedInstance;
- (NSArray *)currenciesData;

@end
