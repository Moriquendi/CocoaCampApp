//
//  MSStyleSheet.h
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 31.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSStyleSheet : NSObject

@property (nonatomic, readonly, strong) UIColor *mainBackgroundColor;
@property (nonatomic, readonly, strong) UIColor *separatorColor;
@property (nonatomic, readonly, strong) UIColor *darkTextColor;
@property (nonatomic, readonly, strong) UIColor *lightTextColor;

+ (instancetype)sharedInstance;

@end
