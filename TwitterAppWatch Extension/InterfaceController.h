//
//  InterfaceController.h
//  TwitterAppWatch Extension
//
//  Created by Hegyi Hajnalka on 13/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import <WatchKit/WatchKit.h>

@interface InterfaceController : WKInterfaceController <WCSessionDelegate>

@property(nonatomic,unsafe_unretained) IBOutlet WKInterfaceLabel *noTweetsLabel;
@property(nonatomic,unsafe_unretained) IBOutlet WKInterfaceTable *tweetTable;

@end
