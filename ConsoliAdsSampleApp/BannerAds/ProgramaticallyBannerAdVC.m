//
//  BannerAdProgramatically.m
//  ConsoliAdsSampleApp
//
//  Created by fazalWFH on 5/4/20.
//  Copyright © 2020 ConsoliAds. All rights reserved.
//

#import "ProgramaticallyBannerAdVC.h"
#import "ConsoliAdsMediation.h"
#import "CAMediatedBannerView.h"
#import "AppDelegate.h"
#import "Config.h"

@interface ProgramaticallyBannerAdVC () <CAMediatedBannerAdViewDelegate> {
    CAMediatedBannerView *bannerView;
}

@end

@implementation ProgramaticallyBannerAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showBanner:(UIButton*)sender {
    
    bannerView = [[CAMediatedBannerView alloc] init];
    bannerView.delegate = self;
    [[ConsoliAdsMediation sharedInstance] showBannerWithIndex:[AppDelegate sharedInstance].configuration.sceneIndex bannerView:bannerView viewController:self];

}

- (void)onBannerAdLoaded:(CAMediatedBannerView *)bannerView {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [bannerView removeFromSuperview];
    [self.view addSubview:bannerView];
    [self setBannerViewPosition:bannerView];
}

#pragma positionBannerView

- (void)setBannerViewPosition:(UIView*)bannerView {

    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(ios 11.0, *)) {
        [self positionBannerViewToSafeArea:bannerView];
    }
    else {
        [self positionBannerView:bannerView];
    }
}

- (void)positionBannerViewToSafeArea:(UIView*)bannerView NS_AVAILABLE_IOS(11.0) {
        
    [bannerView.centerYAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.centerYAnchor].active = YES;
    [bannerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
}

- (void)positionBannerView:(UIView *)bannerView {
    
    [self.view addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:bannerView
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:bannerView
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1
                                                         constant:0]
                           ]];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
