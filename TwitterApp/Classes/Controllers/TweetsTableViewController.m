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

@interface TweetsTableViewController() <UISearchResultsUpdating>
@property (nonatomic, strong) TwitterManager *twitterManager;
@property (nonatomic, strong) NSMutableArray *tweetArray;  //of Tweets
@property (nonatomic, strong) NSMutableArray *filteredTweetArray;
@property (nonatomic, strong) UISearchController *searchController;
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

-(NSMutableArray *)filteredTweetArray
{
    if (!_filteredTweetArray)
    {
        _filteredTweetArray = [[NSMutableArray alloc] init];
    }
    return _filteredTweetArray;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;

    self.tableView.estimatedRowHeight = 50.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.twitterManager getRecentTweetsOnCompletion:^(NSArray* tweetsArray) {
        [self.tweetArray addObjectsFromArray:tweetsArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    Tweet *newTweet = [[Tweet alloc] init];
    if ([self.searchController isActive] && ![self.searchController.searchBar.text isEqualToString:@""]) {
        newTweet = [self.filteredTweetArray objectAtIndex:indexPath.row];
    } else {
        newTweet = [self.tweetArray objectAtIndex:indexPath.row];
    }
    cell.tweetCellData = [newTweet cellDataRepresentation];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.searchController isActive] && ![self.searchController.searchBar.text isEqualToString:@""])
    {
        return [self.filteredTweetArray count];
    }
    return [self.tweetArray count];
}

- (IBAction)postTweet:(UIBarButtonItem *)sender
{
    [self presentViewController:[self.twitterManager composeTweet] animated:YES completion:NULL];
}

- (void)filteredContentForSearchText:(NSString *)searchText
{
    [self.filteredTweetArray removeAllObjects];
    for (Tweet *tweet in self.tweetArray)
    {
        TweetCellData *tweetData = [tweet cellDataRepresentation];
        if ([tweetData.tweetMessage.lowercaseString containsString:searchText.lowercaseString])
        {
            [self.filteredTweetArray addObject:tweet];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self filteredContentForSearchText:searchController.searchBar.text];
}

@end
