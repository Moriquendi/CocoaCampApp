//
//  MSDataCurrency.h
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 31.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSDataCurrency : NSObject

@property (nonatomic, readonly) NSString *fullName;
@property (nonatomic, readonly) NSString *ISOCurrencyCode;
@property (nonatomic, readonly) NSString *flagImageName;
@property (nonatomic, readonly) NSArray *moneyImagesNames;
@property (nonatomic, readonly) CGFloat toDollarRatio;

- (id)initWithContent:(NSDictionary *)content;

@end
