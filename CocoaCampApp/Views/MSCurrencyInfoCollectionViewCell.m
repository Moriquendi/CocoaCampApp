//
//  MSCurrencyInfoCollectionViewCell.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSCurrencyInfoCollectionViewCell.h"

@implementation MSCurrencyInfoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *contentView = [[NSBundle mainBundle] loadNibNamed:@"MSCurrencyInfoCollectionView"
                                                            owner:self
                                                          options:nil][0];
        [self.contentView addSubview:contentView];
    }
    return self;
}

@end
