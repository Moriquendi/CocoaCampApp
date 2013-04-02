//
//  MSRootViewController.h
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSCurrencyPickerViewController.h"
#import "MSViewController.h"

@interface MSRootViewController : MSViewController
<UITableViewDataSource,
UITableViewDelegate,
MSPickerDelegate>

@property (nonatomic, readonly, strong) NSArray *currencies; // of MSDataCurrency

@end
