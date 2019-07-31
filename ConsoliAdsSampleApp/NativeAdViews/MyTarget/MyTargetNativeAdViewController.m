//
//  MyTargetNativeAdViewController.m
//  LeadboltSampleApp
//
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "MyTargetNativeAdViewController.h"
#import "ConsoliAdsMediation.h"
#import "AppDelegate.h"
#import "Config.h"

@interface MyTargetNativeAdViewController ()

@end

@implementation MyTargetNativeAdViewController

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

- (IBAction)loadBtnClicked:(id)sender {

    [[ConsoliAdsMediation sharedInstance] configureMyTargetNativeAdWithSceneIndex:[AppDelegate sharedInstance].configuration.sceneIndex adViewContainer:_containerView viewController:self];
    [[ConsoliAdsMediation sharedInstance] ShowNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex viewController:self];
}

- (void)Destroy:(id)sender {
    [[ConsoliAdsMediation sharedInstance] onDestroyForNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex];
}

@end
