//
//  TweetCellData.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "TweetCellData.h"

@implementation TweetCellData


-(instancetype)initWithUsername:(NSString *)twitterUsername withTweetMessage:(NSString *)tweetMessage withTweetTime:(NSString *)tweetTime withProfilePictureURL:(NSString *)imageURL
{
    self = [super init];
    if (self)
    {
        _twitterUsername = twitterUsername;
        _tweetMessage = tweetMessage;
        _tweetTime = tweetTime;
        _profilePictureURL = imageURL;
    }
    return self;
}

@end
