//
//  MSDataCurrency.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 31.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSDataCurrency.h"

@interface MSDataCurrency ()

@property (nonatomic, readwrite) NSString *fullName;
@property (nonatomic, readwrite) NSString *ISOCurrencyCode;
@property (nonatomic, readwrite) NSString *flagImageName;
@property (nonatomic, readwrite) NSArray *moneyImagesNames;
@property (nonatomic, readwrite) CGFloat toDollarRatio;

@end

@implementation MSDataCurrency

- (id)initWithContent:(NSDictionary *)content
{
    if (self = [super init]) {
        self.fullName = content[@"fullName"];
        self.ISOCurrencyCode = content[@"ISOCurrencyCode"];
        self.flagImageName = content[@"flagImageName"];
        self.moneyImagesNames = content[@"moneyImagesNames"];
        self.toDollarRatio = [content[@"toDollarRatio"] floatValue];
    }
    return self;
}

@end
