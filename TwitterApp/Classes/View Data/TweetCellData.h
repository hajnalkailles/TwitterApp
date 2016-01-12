//
//  TweetCellData.h
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetCellData : NSObject

@property (nonatomic, copy, readonly) NSString *twitterUsername;
@property (nonatomic, copy, readonly) NSString *tweetMessage;
@property (nonatomic, copy, readonly) NSString *tweetTime;
@property (nonatomic, copy, readonly) NSString *profilePictureURL;

-(instancetype)initWithUsername:(NSString *)twitterUsername withTweetMessage:(NSString *)tweetMessage withTweetTime:(NSString *)tweetTime withProfilePictureURL:(NSString *)imageURL;

@end
