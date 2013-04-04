//
//  MSCurrencySummaryViewController.h
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 31.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"
#import "MSDataCurrency.h"

@interface MSCurrencySummaryViewController : MSViewController

- (id)initWithCurrencyData:(MSDataCurrency *)currency;

@end
