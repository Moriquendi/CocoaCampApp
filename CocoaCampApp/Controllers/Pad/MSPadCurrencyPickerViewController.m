//
//  MSPadCurrencyPickerViewController.m
//  CocoaCampApp
//
//  Created by Michal Smialko on 02.04.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSPadCurrencyPickerViewController.h"

@implementation MSPadCurrencyPickerViewController

#pragma mark - UIViewController

- (CGSize)contentSizeForViewInPopover
{
    CGSize contentSize = [super contentSizeForViewInPopover];
    contentSize.height = self.collectionView.contentSize.height;
    contentSize.height += self.collectionView.frame.origin.y;
    return  contentSize;
}

@end
