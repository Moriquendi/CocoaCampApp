//
//  MSClient.m
//  CocoaCampApp
//
//  Created by Michal Smialko on 03.04.2013.
//  Copyright (c) 2013 MS. All rights reserved.
//

#import "MSClient.h"
#import "MSDataCurrency.h"

#define API_KEY @"a5cc6d9b99d2c601b0b44dafd2b0537ee4882fc0"

@implementation MSClient

#pragma mark - + MSClient

+ (instancetype)sharedInstance
{
    static MSClient *_sharedInstance = nil;

    if (!_sharedInstance) {
        _sharedInstance = [[MSClient alloc] init];
    }

    return _sharedInstance;
}

#pragma mark - MSClient

- (NSArray *)currenciesData
{
    NSMutableArray *currenciesData = [[NSMutableArray alloc] init];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"CurrenciesList" ofType:@"plist"];
    NSDictionary *fileContent = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *avaiableCurrenciesList = fileContent[@"availableCurrenciesData"];

    for (NSString *fileName in avaiableCurrenciesList) {
        path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        NSDictionary *content = [[NSDictionary alloc] initWithContentsOfFile:path];
        MSDataCurrency *currencyData = [[MSDataCurrency alloc] initWithContent:content];
        [currenciesData addObject:currencyData];
    }

    return currenciesData;
}

#pragma mark - MSClient ()

- (CGFloat)_convertCurrency:(NSString *)fromCurrencyName toCurrency:(NSString *)toCurrencyName
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://currency-api.appspot.com/api/%@/%@.json?key=%@", fromCurrencyName, toCurrencyName, API_KEY]];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:url];

        [self performSelectorOnMainThread:@selector(_parseData:)
                               withObject:data
                            waitUntilDone:YES];
    });

    return  0;
}

- (void)_parseData:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];

    NSLog(@"%@", json);
}

@end
