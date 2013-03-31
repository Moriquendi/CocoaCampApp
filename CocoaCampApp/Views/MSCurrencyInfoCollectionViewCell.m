//
//  MSCurrencyInfoCollectionViewCell.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSCurrencyInfoCollectionViewCell.h"

@interface MSCurrencyInfoCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation MSCurrencyInfoCollectionViewCell

#pragma mark - UIView

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

#pragma mark - UICollectionViewCell

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    if (selected) {
        self.backgroundView.backgroundColor = [UIColor colorWithRed:241.f/255.f green:71.f/255.f blue:66.f/255.f alpha:1.0];
    }
    else {
        self.backgroundView.backgroundColor = [UIColor colorWithRed:152.f/255.f green:210.f/255.f blue:240.f/255.f alpha:1.0];
    }
}

@end
