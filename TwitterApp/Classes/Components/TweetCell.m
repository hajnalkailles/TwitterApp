//
//  TweetCell.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "TweetCell.h"
#import <UIKit/UIKit.h>

@interface TweetCell()


@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTimeLabel;


@end

@implementation TweetCell

-(void)setRoundedImage
{
    self.profilePicture.layer.cornerRadius = 46.0/2.0;
    self.profilePicture.layer.borderColor = [UIColor blackColor].CGColor;
    self.profilePicture.layer.borderWidth = 1.0;
    self.profilePicture.layer.masksToBounds = NO;
    self.profilePicture.clipsToBounds = YES;
}

@end
