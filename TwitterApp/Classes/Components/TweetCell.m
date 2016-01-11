//
//  TweetCell.m
//  TwitterApp
//
//  Created by Hegyi Hajnalka on 11/01/16.
//  Copyright © 2016 Hegyi Hajnalka. All rights reserved.
//

#import "TweetCell.h"
#import <UIKit/UIKit.h>
#import "TweetCellData.h"

@interface TweetCell()

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTimeLabel;

@end

@implementation TweetCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setRoundedImage];
}

-(void)setRoundedImage
{
    self.profilePicture.layer.cornerRadius = 46.0/2.0;
    self.profilePicture.layer.borderColor = [UIColor blackColor].CGColor;
    self.profilePicture.layer.borderWidth = 1.0;
    self.profilePicture.layer.masksToBounds = NO;
    self.profilePicture.clipsToBounds = YES;
}

-(void)setTweetCellData:(TweetCellData *)tweetCellData
{
    _tweetCellData = tweetCellData;
    self.usernameLabel.text = tweetCellData.twitterUsername;
    self.tweetMessageLabel.text = tweetCellData.tweetMessage;
    self.tweetTimeLabel.text = tweetCellData.tweetTime;
    
    NSURL *imageFetchURL = [NSURL URLWithString:tweetCellData.profilePictureURL];
    if (imageFetchURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:imageFetchURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
            completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error){
                if (!error){
                    NSData *jsonResults = [NSData dataWithContentsOfURL: localfile];
                    UIImage *profileImage = [UIImage imageWithData:jsonResults];
                                                                
                    dispatch_async(dispatch_get_main_queue(), ^{self.profilePicture.image = profileImage;});
                    }
                }];
        [task resume];
    }

}

@end
