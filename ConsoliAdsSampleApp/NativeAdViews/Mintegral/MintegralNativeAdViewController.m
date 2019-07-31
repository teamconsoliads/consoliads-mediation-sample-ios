//
//  MintegralNativeAdViewController.m
//  LeadboltSampleApp
//
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "MintegralNativeAdViewController.h"
#import "ConsoliAdsMediation.h"
#import "AppDelegate.h"
#import "Config.h"

@interface MintegralNativeAdViewController ()

@end

@implementation MintegralNativeAdViewController

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

    [[ConsoliAdsMediation sharedInstance] configureMintegralNativeAdWithSceneIndex:[AppDelegate sharedInstance].configuration.sceneIndex contentView:self.containerView appNameLabel:self.appName appDescLabel:self.descLabel iconImageView:self.image adCallButton:self.adCallButton MGMediaView:self.mtgView adChoicesView:self.adChoices viewController:self];
    [[ConsoliAdsMediation sharedInstance] ShowNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex viewController:self];
}

- (void)Destroy:(id)sender {
    [[ConsoliAdsMediation sharedInstance] onDestroyForNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex];
}

@end
