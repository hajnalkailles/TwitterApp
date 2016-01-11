//
//  TwitterManager.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "TwitterManager.h"
#import <Social/Social.h>

@implementation TwitterManager

+(SLComposeViewController *)composeTweet
{
    SLComposeViewController *tweet = nil;
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweet setInitialText:@"Tweeting about..."];
    }
    return tweet;
}

@end
