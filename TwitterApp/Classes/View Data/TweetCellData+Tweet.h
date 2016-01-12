//
//  TweetCellData+Tweet.h
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 12/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "TweetCellData.h"

@interface TweetCellData (Tweet)

+(TweetCellData *)cellDataRepresentationForTweetDictionary:(NSDictionary *)tweetDictionary;

@end
