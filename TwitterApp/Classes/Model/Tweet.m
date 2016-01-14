//
//  Tweet.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 12/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "Tweet.h"
#import "TweetCellData.h"

@interface  Tweet()
@property (nonatomic, copy, readonly) NSString *twitterUsername;
@property (nonatomic, copy, readonly) NSString *tweetMessage;
@property (nonatomic, copy, readonly) NSString *tweetTime;
@property (nonatomic, copy, readonly) NSString *profilePictureURL;
@end

@implementation Tweet

-(instancetype)initWithDictionary:(NSDictionary *)tweetDictionary
{
    self = [super init];
    if (self)
    {
        _tweetMessage = [tweetDictionary valueForKey:TWEET_JSON_TWEETMESSAGE];
        _twitterUsername = [NSString stringWithFormat:@"@%@", [[tweetDictionary valueForKey:TWEET_JSON_TWITTERUSER] valueForKey:TWEET_JSON_TWITTERUSERNAME]];
        _tweetTime = [self calculateElapsedTimeFromString: [tweetDictionary valueForKey:TWEET_JSON_TWEETTIME]];
        _profilePictureURL= [[tweetDictionary valueForKey:TWEET_JSON_TWITTERUSER] valueForKey:TWEET_JSON_TWITTERAVATAR];
    }
    return self;
}

-(instancetype)initWithSimpleDictionary:(NSDictionary *)tweetDictionary
{
    self = [super init];
    if (self)
    {
        _tweetMessage = [tweetDictionary valueForKey:TWEET_JSON_TWEETMESSAGE];
        _twitterUsername = [tweetDictionary valueForKey:TWEET_JSON_TWITTERUSERNAME];
        _tweetTime = [tweetDictionary valueForKey:TWEET_JSON_TWEETTIME];
        _profilePictureURL = [tweetDictionary valueForKey:TWEET_JSON_TWITTERAVATAR];
    }
    return self;
}

-(NSString *)calculateElapsedTimeFromString:(NSString *)tweetTime
{
    NSMutableString * timeSinceTweet = [[NSMutableString alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"E MMM dd HH:mm:ss Z yyyy"];
    NSDate *tweetDate = [dateFormatter dateFromString:tweetTime];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval elapsedTime = [currentDate timeIntervalSinceDate:tweetDate];
    NSInteger minutes = elapsedTime/60.0;
    if (minutes > 60) {
        NSInteger hours = minutes/60.0;
        if (hours > 24) {
            NSInteger days = hours/24.0;
            timeSinceTweet = [NSMutableString stringWithFormat:@"%ldd", (long)days];
        } else {
            timeSinceTweet = [NSMutableString stringWithFormat:@"%ldh", (long)hours];
        }
    } else {
        timeSinceTweet = [NSMutableString stringWithFormat:@"%ldm", (long)minutes];
    }
    
    return timeSinceTweet;
}

-(TweetCellData *)cellDataRepresentation
{
    TweetCellData *tweetData = [[TweetCellData alloc] initWithUsername:self.twitterUsername withTweetMessage:self.tweetMessage withTweetTime:self.tweetTime withProfilePictureURL:self.profilePictureURL];
    return tweetData;
}

@end
