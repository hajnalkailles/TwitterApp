//
//  TweetCellData.h
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetCellData : NSObject

@property (nonatomic, readonly) NSString *twitterUsername;
@property (nonatomic, readonly) NSString *tweetMessage;
@property (nonatomic, readonly) NSString *tweetTime;
@property (nonatomic, readonly) NSString *profilePictureURL;

-(TweetCellData *)initWithUsername:(NSString *)twitterUsername withTweetMessage:(NSString *)tweetMessage withTweetTime:(NSString *)tweetTime withProfilePictureURL:(NSString *)imageURL;

@end
