//
//  TwitterManager.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "TwitterManager.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "Tweet.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface TwitterManager()
@property (nonatomic, copy) NSMutableArray* fetchedTweets;
@end

@implementation TwitterManager

-(NSMutableArray *)fetchedTweets
{
    if (!_fetchedTweets)
    {
        _fetchedTweets = [[NSMutableArray alloc] init];
    }
    return _fetchedTweets;
}

-(SLComposeViewController *)composeTweet
{
    SLComposeViewController *tweet = nil;
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweet setInitialText:@"Tweeting about..."];
    }
    return tweet;
}

-(void)getRecentTweetsOnCompletion:(tweetsLoadedCompletion) completionBlock
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            if (accounts.count > 0)
            {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                
                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:TWITTER_HOME_TIMELINE_URL] parameters:[NSDictionary dictionaryWithObjects:@[twitterAccount.username, TWITTER_FETCH_COUNT_VALUE] forKeys: @[TWITTER_USERNAME_KEY, TWITTER_FETCH_COUNT_KEY]]];
                twitterInfoRequest.account = twitterAccount;
                
                NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
                NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
                NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:twitterInfoRequest.preparedURLRequest
                        completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error){
                            if (!error){
                                NSData *jsonResults = [NSData dataWithContentsOfURL: localfile];
                                NSDictionary *tweetDictionary =  [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
                                
                                NSMutableArray *tweetList = [[NSMutableArray alloc] init];
                                
                                for (NSDictionary* tweet in tweetDictionary)
                                {
                                    Tweet *myTweet = [[Tweet alloc] initWithDictionary: tweet];
                                    [tweetList addObject:myTweet];
                                }
                                self.fetchedTweets = tweetList;
                                [self sendRecentTweetsToWatch];
                                completionBlock(tweetList);
                            }
                        }];
                    [task resume];
                }
            }
    }];
}

-(void)setupWatchConnectivity {
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}

-(void)sendRecentTweetsToWatch {
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        if (session.watchAppInstalled) {
            
            NSMutableDictionary *tweetsToSendDictionary = [[NSMutableDictionary alloc] init];
            int index = 0;
            for (Tweet *tweet in self.fetchedTweets)
            {
                TweetCellData *celldata = [tweet cellDataRepresentation];
                NSDictionary *newTweet = @{TWEET_JSON_TWEETMESSAGE: celldata.tweetMessage, TWEET_JSON_TWITTERUSERNAME: celldata.twitterUsername, TWEET_JSON_TWEETTIME: celldata.tweetTime, TWEET_JSON_TWITTERAVATAR: celldata.profilePictureURL};
                [tweetsToSendDictionary setValue:newTweet forKey:[NSString stringWithFormat:@"%d", index]];
                index++;
            }
            
            [session updateApplicationContext: tweetsToSendDictionary error:nil];
        }
    }
}

@end
