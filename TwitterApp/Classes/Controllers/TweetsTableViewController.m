//
//  TweetsTableViewController.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "TweetsTableViewController.h"
#import "TweetCell.h"
#import "TweetCellData.h"
#import "TwitterManager.h"

@implementation TweetsTableViewController

-(void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoadingTweets:) name:TWEETS_RECEIVED_NOTIFICATION object:nil];
}

-(void)didFinishLoadingTweets:(NSNotification *)note
{
    NSLog(@"%@", note.userInfo);
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 50.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [TwitterManager getRecentTweets];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    
    //sample data
    TweetCellData *tweet = [[TweetCellData alloc] initWithUsername:@"@test_user" withTweetMessage:@"This is my tweet message!" withTweetTime:@"2h" withProfilePictureURL:@"https://upload.wikimedia.org/wikipedia/en/7/70/Shawn_Tok_Profile.jpg"];
    cell.tweetCellData = tweet;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (IBAction)postTweet:(UIBarButtonItem *)sender
{
    [self presentViewController:[TwitterManager composeTweet] animated:YES completion:NULL];
}


@end
