//
//  MSConvertedCurrencyTableViewCell.h
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSConvertedCurrencyTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *fullCurrencyName;
@property (nonatomic, strong) NSString *ISOCurrencySymbol;
@property (nonatomic, strong) NSString *amount;

@end
