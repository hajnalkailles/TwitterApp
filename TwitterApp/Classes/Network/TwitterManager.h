//
//  TwitterManager.h
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>

#define TWITTER_HOME_TIMELINE_URL @"https://api.twitter.com/1.1/statuses/home_timeline.json"
#define TWITTER_USERNAME_KEY @"screen_name"
#define TWITTER_FETCH_COUNT_KEY @"count"
#define TWITTER_FETCH_COUNT_VALUE @"25"

@interface TwitterManager : NSObject

typedef void(^tweetsLoadedCompletion)(NSArray*);

-(SLComposeViewController *)composeTweet;
-(void)getRecentTweetsOnCompletion:(tweetsLoadedCompletion)completionBlock;

@end
