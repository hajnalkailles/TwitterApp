//
//  TweetCellData+Tweet.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 12/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "TweetCellData+Tweet.h"

#define TWEET_JSON_TWEETMESSAGE @"text"
#define TWEET_JSON_TWEETTIME @"created_at"
#define TWEET_JSON_TWITTERUSER @"user"
#define TWEET_JSON_TWITTERUSERNAME @"screen_name"
#define TWEET_JSON_TWITTERAVATAR @"profile_image_url"

@implementation TweetCellData (Tweet)

+(TweetCellData *)cellDataRepresentationForTweetDictionary:(NSDictionary *)tweetDictionary
{
    NSString *tweetMessage = [tweetDictionary valueForKey:TWEET_JSON_TWEETMESSAGE];
    NSString *twitterUsername = [NSString stringWithFormat:@"@%@", [[tweetDictionary valueForKey:TWEET_JSON_TWITTERUSER] valueForKey:TWEET_JSON_TWITTERUSERNAME]];
    NSString *tweetTime = [self calculateElapsedTimeFromString: [tweetDictionary valueForKey:TWEET_JSON_TWEETTIME]];
    NSString *profilePictureURL = [[tweetDictionary valueForKey:TWEET_JSON_TWITTERUSER] valueForKey:TWEET_JSON_TWITTERAVATAR];
    TweetCellData *tweetData = [[TweetCellData alloc] initWithUsername:twitterUsername withTweetMessage:tweetMessage withTweetTime:tweetTime withProfilePictureURL:profilePictureURL];
    
    return tweetData;
}

+(NSString *)calculateElapsedTimeFromString:(NSString *)tweetTime
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


@end
