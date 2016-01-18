//
//  InterfaceController.m
//  TwitterAppWatch Extension
//
//  Created by Hegyi Hajnalka on 13/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "InterfaceController.h"
#import "Tweet.h"
#import "TweetRowController.h"

#import <WatchConnectivity/WatchConnectivity.h>

@interface InterfaceController ()

@property(nonatomic,copy) NSMutableArray *tweetList;    //of Tweets

- (NSMutableArray *)tweetList;
- (void)awakeWithContext:(id)context;
- (void)updateTweetTable;
- (void)setupWatchConnectivity;
- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext;

@end

@implementation InterfaceController

#pragma mark - Initialization

- (NSMutableArray *)tweetList
{
    if (_tweetList == nil)
    {
        _tweetList = [[NSMutableArray alloc] init];
    }
    return _tweetList;
}

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    [self setupWatchConnectivity];
    [self updateTweetTable];
}

#pragma mark - Table update

- (void)updateTweetTable
{
    if ([self.tweetList count] > 0)
    {
        [self.noTweetsLabel setHidden:YES];
    } else
    {
        [self.noTweetsLabel setHidden:NO];
    }
    [self.tweetTable setNumberOfRows:[self.tweetList count] withRowType:@"TweetRowType"];
    [self.tweetList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TweetRowController *controller = [self.tweetTable rowControllerAtIndex:idx];
        controller.tweetCellData = [obj cellDataRepresentation];
    }];
}

#pragma mark - WatchConnectivity

- (void)setupWatchConnectivity
{
    if ([WCSession isSupported] == YES)
    {
        WCSession *session  = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}

- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext
{
    for (int index = 0; index < [applicationContext count]; index++)
    {
        NSDictionary *newTweet = [applicationContext valueForKey:[NSString stringWithFormat:@"%d", index]];
        Tweet *tweet = [[Tweet alloc] initWithSimpleDictionary:newTweet];
        [self.tweetList addObject:tweet];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateTweetTable];
    });
}

@end



