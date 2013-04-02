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

@end

@implementation MSCurrencySummaryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Self
    self.title = NSLocalizedString(@"Summary", nil);

    // Flag image
    self.flagImageView.image = [UIImage imageNamed:@"usa-flag"];

    // Currency details text view
    self.currencyDetailsTextView.text = @"Bla bla bla\nBlabla bla\nBlaBla Bla\nBla.";

    // Scroll view with images of money.
    UIImage *im1 = [UIImage imageNamed:@"usa-flag"];
    UIImage *im2 = [UIImage imageNamed:@"usa-flag"];
    UIImage *im3 = [UIImage imageNamed:@"usa-flag"];
    self.currencyImages = @[im1, im2, im3];

    NSInteger pageNumber = 0;
    for (UIImage *image in self.currencyImages) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectOffset(self.currenciesImagesScrollView.bounds,
                                       pageNumber * self.currenciesImagesScrollView.bounds.size.width,
                                       0);
        [self.currenciesImagesScrollView addSubview:imageView];
        pageNumber ++;
    }
    self.currenciesImagesScrollView.contentSize = CGSizeMake(self.currenciesImagesScrollView.bounds.size.width * pageNumber,
                                                             self.currenciesImagesScrollView.bounds.size.height);


    // Wikipedia content
//    NSURL *wikipediaURL = [NSURL URLWithString:@"http://en.wikipedia.org/wiki/Dollar"];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:wikipediaURL];
//    [self.currencyDetailsWebView loadRequest:request];
}

@end
