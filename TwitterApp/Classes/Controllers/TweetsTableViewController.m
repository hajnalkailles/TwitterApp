//
//  TweetsTableViewController.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "TweetsTableViewController.h"
#import "TweetCell.h"

@implementation TweetsTableViewController

-(void)viewDidLoad
{
    self.tableView.estimatedRowHeight = 50.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    [cell setRoundedImage];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section      {
    return 5;
}

@end
