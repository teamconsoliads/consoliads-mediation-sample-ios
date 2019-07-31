//
//  StartAppNativeAdViewController.m
//  LeadboltSampleApp
//
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "StartAppNativeAdViewController.h"
#import "ConsoliAdsMediation.h"
#import "AppDelegate.h"
#import "Config.h"

@interface StartAppNativeAdViewController ()

@end

@implementation StartAppNativeAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Destroy"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(Destroy:)];
    self.navigationItem.rightBarButtonItem = flipButton;
    
}

#pragma mark Button Click

- (IBAction)loadBtnClicked:(id)sender  {
    
    [[ConsoliAdsMediation sharedInstance] configureStartAppNativeAdWithSceneIndex:[AppDelegate sharedInstance].configuration.sceneIndex ratingImageView:_rating titleLabel:_titleLabel descriptionLabel:_descriptionLabel mediaView:_mediaImageView containerView:_containerView viewController:self];    
    [[ConsoliAdsMediation sharedInstance] ShowNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex viewController:self];
}

- (void)Destroy:(id)sender  {
    [[ConsoliAdsMediation sharedInstance] onDestroyForNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex];
}

@end
