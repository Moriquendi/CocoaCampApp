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
        self.backgroundView.backgroundColor = [UIColor redColor];
    }
    else {
        self.backgroundView.backgroundColor = [UIColor blueColor];
    }
}

@end
