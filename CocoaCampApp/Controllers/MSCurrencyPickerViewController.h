//
//  MSCurrencyPickerViewController.h
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 01.04.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"

@class MSCurrencyPickerViewController;

@protocol MSPickerDelegate <NSObject>
@optional
- (void)currencyPicker:(MSCurrencyPickerViewController *)picker didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)currencyPicker:(MSCurrencyPickerViewController *)picker didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface MSCurrencyPickerViewController : MSViewController
<UICollectionViewDataSource,
UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, readonly, strong) NSArray *currencies;
@property (nonatomic, weak) id <MSPickerDelegate> delegate;

- (id)initWithCurrencies:(NSArray *)currencies; // designated initializer

@end
