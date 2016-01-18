//
//  TweetsTableViewController.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "Tweet.h"
#import "TweetCell.h"
#import "TweetCellData.h"
#import "TweetsTableViewController.h"
#import "TwitterManager.h"

@interface TweetsTableViewController ()

@property(nonatomic,copy) NSMutableArray *tweetArray;  //of Tweets
@property(nonatomic,copy) NSMutableArray *filteredTweetArray;
@property(nonatomic,strong) TwitterManager *twitterManager;
@property(nonatomic,strong) UISearchController *searchController;

- (NSMutableArray *)tweetArray;
- (NSMutableArray *)filteredTweetArray;
- (TwitterManager *)twitterManager;
- (void)viewDidLoad;
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController;
- (void)filteredContentForSearchText:(NSString *)searchText;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation TweetsTableViewController

#pragma mark - Initialization

- (NSMutableArray *)tweetArray
{
    if (_tweetArray == nil)
    {
        _tweetArray = [[NSMutableArray alloc] init];
    }
    return _tweetArray;
}

- (NSMutableArray *)filteredTweetArray
{
    if (_filteredTweetArray == nil)
    {
        _filteredTweetArray = [[NSMutableArray alloc] init];
    }
    return _filteredTweetArray;
}

- (TwitterManager *)twitterManager
{
    if (_twitterManager == nil)
    {
        _twitterManager = [[TwitterManager alloc] init];
    }
    return _twitterManager;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;

    self.tableView.estimatedRowHeight = 50.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.twitterManager setupWatchConnectivity];
    [self.twitterManager getRecentTweetsOnCompletion:^(NSArray *tweetsArray) {
        [self.tweetArray addObjectsFromArray:tweetsArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Actions

- (IBAction)postTweet:(UIBarButtonItem *)sender
{
    [self presentViewController:[self.twitterManager composeTweet] animated:YES completion:NULL];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self filteredContentForSearchText:searchController.searchBar.text];
}

- (void)filteredContentForSearchText:(NSString *)searchText
{
    [self.filteredTweetArray removeAllObjects];
    for (Tweet *tweet in self.tweetArray)
    {
        TweetCellData *tweetData = [tweet cellDataRepresentation];
        if ([tweetData.tweetMessage.lowercaseString containsString:searchText.lowercaseString] == YES)
        {
            [self.filteredTweetArray addObject:tweet];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (([self.searchController isActive] == YES) && ([self.searchController.searchBar.text isEqualToString:@""] == NO))
    {
        return [self.filteredTweetArray count];
    }
    return [self.tweetArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    Tweet *newTweet = [[Tweet alloc] init];
    if (([self.searchController isActive] == YES) && ([self.searchController.searchBar.text isEqualToString:@""] == NO))
    {
        newTweet = [self.filteredTweetArray objectAtIndex:indexPath.row];
    }
    else
    {
        newTweet = [self.tweetArray objectAtIndex:indexPath.row];
    }
    cell.tweetCellData = [newTweet cellDataRepresentation];
    return cell;
}

@end
