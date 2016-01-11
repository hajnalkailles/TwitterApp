//
//  TweetCellData.h
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetCellData : NSObject

@property (nonatomic, copy) NSString *twitterUsername;
@property (nonatomic, copy) NSString *tweetMessage;
@property (nonatomic, copy) NSString *tweetTime;
@property (nonatomic, copy) NSString *profilePictureURL;

@end
