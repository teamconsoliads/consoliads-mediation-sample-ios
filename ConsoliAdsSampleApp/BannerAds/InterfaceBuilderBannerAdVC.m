//
//  BannerAdInterfaceBuilder.m
//  ConsoliAdsSampleApp
//
//  Created by fazalWFH on 5/4/20.
//  Copyright © 2020 ConsoliAds. All rights reserved.
//

#import "InterfaceBuilderBannerAdVC.h"
#import "ConsoliAdsMediation.h"
#import "AppDelegate.h"
#import "Config.h"

@implementation InterfaceBuilderBannerAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showBanner:(UIButton*)sender {
    [[ConsoliAdsMediation sharedInstance] showBannerWithIndex:[AppDelegate sharedInstance].configuration.sceneIndex bannerView:self.bannerView viewController:self];
}


@end
