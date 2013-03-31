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
@property (weak, nonatomic) IBOutlet UIWebView *currencyDetailsWebView;

@end

@implementation MSCurrencySummaryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.flagImageView.image = [UIImage imageNamed:@"usa-flag"];
    NSURL *wikipediaURL = [NSURL URLWithString:@"http://en.wikipedia.org/wiki/Dollar"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:wikipediaURL];
    [self.currencyDetailsWebView loadRequest:request];
}

@end
