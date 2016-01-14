//
//  InterfaceController.m
//  TwitterAppWatch Extension
//
//  Created by Hegyi Hajnalka on 13/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "Tweet.h"
#import "TweetRowController.h"

@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *noTweetsLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *tweetTable;
@property (nonatomic) NSMutableArray* tweetList;    //of Tweets
@end

@implementation InterfaceController

-(NSMutableArray *)tweetList {
    if (!_tweetList) {
        _tweetList = [[NSMutableArray alloc] init];
    }
    return _tweetList;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self setupWatchConnectivity];
    [self updateTweetTable];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(void)updateTweetTable
{
    if ([self.tweetList count] > 0) {
        [self.noTweetsLabel setHidden:YES];
    } else {
        [self.noTweetsLabel setHidden:NO];
    }
    [self.tweetTable setNumberOfRows:[self.tweetList count] withRowType:@"TweetRowType"];
    int index = 0;
    for (id tweet in self.tweetList) {
        TweetRowController *controller = [self.tweetTable rowControllerAtIndex:index];
        controller.tweetCellData = [tweet cellDataRepresentation];
        index++;
    }
}

-(void)setupWatchConnectivity {
    if ([WCSession isSupported]) {
        WCSession *session  = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}

-(void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext
{
    for (int index = 0; index < [applicationContext count]; index++) {
        NSDictionary *newTweet = [applicationContext valueForKey:[NSString stringWithFormat:@"%d", index]];
        Tweet *tweet = [[Tweet alloc] initWithSimpleDictionary:newTweet];
        [self.tweetList addObject:tweet];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateTweetTable];
    });
}

@end



