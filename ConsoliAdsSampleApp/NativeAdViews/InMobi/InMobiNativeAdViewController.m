//
//  InMobiNativeAdViewController.m
//  LeadboltSampleApp
//
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "InMobiNativeAdViewController.h"
#import "ConsoliAdsMediation.h"
#import "AppDelegate.h"
#import "Config.h"

@interface InMobiNativeAdViewController ()

@end

@implementation InMobiNativeAdViewController

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
    
    [[ConsoliAdsMediation sharedInstance] configureInMobiNativeAdWithSceneIndex:[AppDelegate sharedInstance].configuration.sceneIndex iconImageView:_iconImageView titleLabel:_titleLabel contentView:_contentView adViewContainer:_containerView viewController:self];
    [[ConsoliAdsMediation sharedInstance] ShowNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex viewController:self];
}

- (void)Destroy:(id)sender  {
    [[ConsoliAdsMediation sharedInstance] onDestroyForNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex];
}

@end
