//
//  ALDemoNativeAdProgrammaticViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/24/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoNativeAdProgrammaticViewController.h"
#import <AppLovinSDK/AppLovinSDK.h>
#import "ConsoliAdsMediation.h"
#import "AppDelegate.h"
#import "Config.h"

@interface ALDemoNativeAdProgrammaticViewController()
@end


@implementation ALDemoNativeAdProgrammaticViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appIcon.layer.masksToBounds = YES;
    self.appIcon.layer.cornerRadius = 3.0f;
    
    self.ctaButton.layer.masksToBounds = YES;
    self.ctaButton.layer.cornerRadius = 3.0f;
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Destroy"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(Destroy:)];
    self.navigationItem.rightBarButtonItem = flipButton;
    
}

#pragma mark - Action Methods

- (IBAction)loadNativeAd:(id)sender
{
    [[ConsoliAdsMediation sharedInstance] configureApplovinNativeAdWithSceneIndex:[AppDelegate sharedInstance].configuration.sceneIndex ratingImageView:_rating appIcon:_appIcon titleLabel:_titleLabel descriptionLabel:_descriptionLabel ctaButton:_ctaButton mediaView:_mediaView adViewContainer:self.adViewContainer viewController:self];
    [[ConsoliAdsMediation sharedInstance] ShowNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex viewController:self];
}

- (void)Destroy:(id)sender  {
    [[ConsoliAdsMediation sharedInstance] onDestroyForNativeAd:[AppDelegate sharedInstance].configuration.sceneIndex];
}

- (IBAction)precacheNativeAd:(id)sender
{
}

- (IBAction)showNativeAd:(id)sender
{
    [self.view layoutIfNeeded];
}

- (IBAction)ctaPressed:(id)sender
{
}


@end
