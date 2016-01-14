//
//  Tweet.h
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 12/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetCellData.h"

#define TWEET_JSON_TWEETMESSAGE @"text"
#define TWEET_JSON_TWEETTIME @"created_at"
#define TWEET_JSON_TWITTERUSER @"user"
#define TWEET_JSON_TWITTERUSERNAME @"screen_name"
#define TWEET_JSON_TWITTERAVATAR @"profile_image_url"

@interface Tweet : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)tweetDictionary;
-(instancetype)initWithSimpleDictionary:(NSDictionary *)tweetDictionary;
-(TweetCellData *)cellDataRepresentation;

@end
