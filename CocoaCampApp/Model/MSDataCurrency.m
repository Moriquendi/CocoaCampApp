//
//  MSDataCurrency.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 31.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSDataCurrency.h"

@interface MSDataCurrency ()

@property (nonatomic, readwrite, strong) NSString *fullName;
@property (nonatomic, readwrite, strong) NSString *ISOCurrencyCode;
@property (nonatomic, readwrite, strong) NSString *flagImageName;
@property (nonatomic, readwrite, strong) NSArray *moneyImagesNames;
@property (nonatomic, readwrite, strong) NSString *currencyDescription;
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
        self.currencyDescription = content[@"description"];
        self.toDollarRatio = [content[@"toDollarRatio"] floatValue];
    }
    return self;
}

@end
