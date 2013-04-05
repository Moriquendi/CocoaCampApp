//
//  MSDataCurrency.h
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 31.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSDataCurrency : NSObject

@property (nonatomic, readonly, strong) NSString *fullName;
@property (nonatomic, readonly, strong) NSString *ISOCurrencyCode;
@property (nonatomic, readonly, strong) NSString *flagImageName;
@property (nonatomic, readonly, strong) NSArray *moneyImagesNames;
@property (nonatomic, readonly, strong) NSString *currencyDescription;
@property (nonatomic) BOOL isDownloadingRates;
@property (nonatomic) CGFloat toDollarRatio;

- (id)initWithContent:(NSDictionary *)content;
- (void)updateWithData:(NSData *)data;

@end
