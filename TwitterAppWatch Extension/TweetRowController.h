//
//  TweetRowController.h
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 14/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>
#import "TweetCellData.h"

@interface TweetRowController : NSObject
@property (nonatomic, strong) TweetCellData *tweetCellData;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *twitterUsernameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *tweetMessageLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *tweetTimeLabel;
@end
