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

@implementation TweetsTableViewController

-(void)viewDidLoad
{
    self.tableView.estimatedRowHeight = 50.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    
    TweetCellData *tweet = [[TweetCellData alloc] initWithUsername:@"@test_user" withTweetMessage:@"This is my tweet message!" withTweetTime:@"2h" withProfilePictureURL:@"https://upload.wikimedia.org/wikipedia/en/7/70/Shawn_Tok_Profile.jpg"];
    
    cell.tweetCellData = tweet;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section      {
    return 5;
}

@end
