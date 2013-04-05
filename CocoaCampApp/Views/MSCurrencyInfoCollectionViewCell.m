//
//  MSCurrencyInfoCollectionViewCell.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 30.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSCurrencyInfoCollectionViewCell.h"
#import "MSStyleSheet.h"

@interface MSCurrencyInfoCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *currencySymbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;
@property (weak, nonatomic) IBOutlet UIView *activityView;

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
        [self setEnabled:YES];
    }
    return self;
}

#pragma mark - UICollectionViewCell

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    self.activityView.hidden = enabled;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    MSStyleSheet *styleSheet = [MSStyleSheet sharedInstance];

    if (selected) {
        self.backgroundView.backgroundColor = [UIColor colorWithRed:241.f/255.f green:71.f/255.f blue:66.f/255.f alpha:1.0];
        self.currencySymbolLabel.textColor = styleSheet.lightTextColor;
        self.currencyNameLabel.textColor = styleSheet.lightTextColor;
    }
    else {
        self.backgroundView.backgroundColor = [UIColor colorWithRed:152.f/255.f green:210.f/255.f blue:240.f/255.f alpha:1.0];
        self.currencySymbolLabel.textColor = styleSheet.darkTextColor;
        self.currencyNameLabel.textColor = styleSheet.darkTextColor;
    }
}

@end
