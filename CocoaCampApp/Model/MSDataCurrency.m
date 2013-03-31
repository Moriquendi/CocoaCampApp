//
//  MSDataCurrency.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 31.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSDataCurrency.h"

@interface MSDataCurrency ()
@property (nonatomic, readwrite) CGFloat toDollarRatio;
@end

@implementation MSDataCurrency

- (id)initWithDollarRatio:(CGFloat)ratio
{
    if (self = [super init]) {
        self.toDollarRatio = ratio;
    }
    return self;
}

@end
