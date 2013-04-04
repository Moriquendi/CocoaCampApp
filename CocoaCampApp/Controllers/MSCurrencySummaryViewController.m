//
//  MSCurrencySummaryViewController.m
//  CocoaCampApp
//
//  Created by Michał Śmiałko on 31.03.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSCurrencySummaryViewController.h"

@interface MSCurrencySummaryViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
//@property (weak, nonatomic) IBOutlet UIWebView *currencyDetailsWebView;
@property (weak, nonatomic) IBOutlet UITextView *currencyDetailsTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *currenciesImagesScrollView;
@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;
@property (nonatomic, strong) NSMutableArray *currencyImages;
@property (nonatomic, strong) MSDataCurrency *currencyData;
@end

@implementation MSCurrencySummaryViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Self
    self.title = NSLocalizedString(@"Summary", nil);

    // Flag image
    self.flagImageView.image = [UIImage imageNamed:self.currencyData.flagImageName];

    // Currency details text view
    self.currencyDetailsTextView.text = self.currencyData.currencyDescription;

    self.currencyImages = [[NSMutableArray alloc] init];
    // Scroll view with images of money.
    for (NSString *imageName in self.currencyData.moneyImagesNames) {
        UIImage *image = [UIImage imageNamed:imageName];
        [self.currencyImages addObject:image];
    }

    NSInteger pageNumber = 0;

    NSMutableArray *imageViews = [[NSMutableArray alloc] initWithCapacity:3];
    for (UIImage *image in self.currencyImages) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageViews addObject:imageView];
    }

    for (UIImageView *imageView in imageViews) {
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectOffset(self.currenciesImagesScrollView.bounds,
                                       pageNumber * self.currenciesImagesScrollView.bounds.size.width,
                                       0);

        [self.currenciesImagesScrollView addSubview:imageView];
        [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];

        // Widths equality
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:imageView
                                                                      attribute:NSLayoutAttributeWidth
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.currenciesImagesScrollView
                                                                      attribute:NSLayoutAttributeWidth
                                                                     multiplier:1.0
                                                                       constant:0];
        [self.currenciesImagesScrollView addConstraint:constraint];

        // Align image views horizontally
        if (pageNumber == 0) {
        constraint = [NSLayoutConstraint constraintWithItem:imageView
                                                  attribute:NSLayoutAttributeLeading
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.currenciesImagesScrollView
                                                  attribute:NSLayoutAttributeLeading
                                                 multiplier:1.0
                                                   constant:0];
        }
        else {
            constraint = [NSLayoutConstraint constraintWithItem:imageViews[pageNumber - 1]
                                                      attribute:NSLayoutAttributeRight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:imageView
                                                      attribute:NSLayoutAttributeLeft
                                                     multiplier:1.0
                                                       constant:0];
        }
        [self.currenciesImagesScrollView addConstraint:constraint];

        // Center vertically
        constraint = [NSLayoutConstraint constraintWithItem:imageView
                                                  attribute:NSLayoutAttributeCenterY
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.currenciesImagesScrollView
                                                  attribute:NSLayoutAttributeCenterY
                                                 multiplier:1.0 constant:0];
        [self.currenciesImagesScrollView addConstraint:constraint];

        pageNumber ++;
    }
    self.currenciesImagesScrollView.contentSize = CGSizeMake(self.currenciesImagesScrollView.bounds.size.width * pageNumber,
                                                             self.currenciesImagesScrollView.bounds.size.height);


    // Wikipedia content
//    NSURL *wikipediaURL = [NSURL URLWithString:@"http://en.wikipedia.org/wiki/Dollar"];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:wikipediaURL];
//    [self.currencyDetailsWebView loadRequest:request];
}

- (void)viewDidLayoutSubviews
{
    self.currenciesImagesScrollView.contentSize = CGSizeMake(self.currenciesImagesScrollView.bounds.size.width * [self.currencyImages count],
                                                             self.currenciesImagesScrollView.bounds.size.height);
}

#pragma mark - MSCurrencySummaryViewController


- (id)initWithCurrencyData:(MSDataCurrency *)currency
{
    if (self = [super init]) {
        self.currencyData = currency;
    }
    return self;
}

@end
