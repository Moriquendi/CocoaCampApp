//
//  MSCurrencyInfoCollectionViewCell.h
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCurrencyInfoCollectionViewCell : UICollectionViewCell

@property (nonatomic, getter = isEnabled) BOOL enabled;
@property (nonatomic, strong) NSString *currencySymbol;
@property (nonatomic, strong) NSString *currencyFullName;

@end
