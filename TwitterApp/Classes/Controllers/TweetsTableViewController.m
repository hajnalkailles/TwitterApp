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
#import "Tweet.h"
#import "TweetCellData+Tweet.h"

@interface TweetsTableViewController()
@property (nonatomic, strong) TwitterManager *twitterManager;
@property (nonatomic, strong) NSMutableArray *tweetArray;  //of Tweets
@end

@implementation TweetsTableViewController

-(TwitterManager *)twitterManager
{
    if (!_twitterManager)
    {
        _twitterManager = [[TwitterManager alloc] init];
    }
    return _twitterManager;
}

-(NSMutableArray *)tweetArray
{
    if (!_tweetArray)
    {
        _tweetArray = [[NSMutableArray alloc] init];
    }
    return _tweetArray;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 50.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.twitterManager getRecentTweetsOnCompletion:^(NSDictionary* tweetsDictionary) {
        for (NSDictionary* tweet in tweetsDictionary)
        {
            [self.tweetArray addObject:[[Tweet alloc] initWithDictionary: tweet]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    Tweet *newTweet = [self.tweetArray objectAtIndex:indexPath.row];
    cell.tweetCellData = [TweetCellData cellDataRepresentationForTweetDictionary:newTweet.tweetData];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tweetArray count];
}

- (IBAction)postTweet:(UIBarButtonItem *)sender
{
    [self presentViewController:[self.twitterManager composeTweet] animated:YES completion:NULL];
}


@end
