//
//  Tweet.h
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 12/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetCellData.h"

@interface Tweet : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)tweetDictionary;
-(TweetCellData *)cellDataRepresentation;

@end
