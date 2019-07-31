//
//  MobfoxNativeAdViewController.m
//  LeadboltSampleApp
//
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "MobfoxNativeAdViewController.h"
#import "ConsoliAdsMediation.h"
#import "AppDelegate.h"
#import "Config.h"

@interface MobfoxNativeAdViewController ()

@end

@implementation MobfoxNativeAdViewController

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
    
    [[ConsoliAdsMediation sharedInstance] configureMobfoxNativeAdWithSceneIndex:[AppDelegate sharedInstance].configuration.sceneIndex nativeAdIcon:_iconImageView nativeAdImage:_ImageView nativeAdTitle:_titleLabel nativeAdDescription:_discriptionLabel adViewContainer:_containerView viewController:self];
    
    [[ConsoliAdsMediation sharedInstance] ShowNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex viewController:self];
}

- (void)Destroy:(id)sender  {
    [[ConsoliAdsMediation sharedInstance] onDestroyForNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex];
}

@end
