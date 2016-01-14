//
//  TweetRowController.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 14/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "TweetRowController.h"

@implementation TweetRowController

-(void)setTweetCellData:(TweetCellData *)tweetCellData {
    _tweetCellData = tweetCellData;
    [self.twitterUsernameLabel setText:tweetCellData.twitterUsername];
    [self.tweetMessageLabel setText:tweetCellData.tweetMessage];
    [self.tweetTimeLabel setText:tweetCellData.tweetTime];
}

@end
