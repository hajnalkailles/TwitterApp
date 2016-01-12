//
//  Tweet.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 12/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "Tweet.h"
#import "TweetCellData.h"

@implementation Tweet

-(Tweet *)initWithDictionary:(NSDictionary *)tweetDictionary
{
    self = [super init];
    if (self)
    {
        _tweetData = tweetDictionary;
    }
    return self;
}

@end
