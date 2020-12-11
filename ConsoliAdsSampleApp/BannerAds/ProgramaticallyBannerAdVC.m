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
    NSString *myTag;
}

@end

@implementation ProgramaticallyBannerAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    bannerView = [[CAMediatedBannerView alloc] init];
    bannerView.delegate = self;

    myTag = @"!--QA-Testing-Listner--!";
}

- (IBAction)showBanner:(UIButton*)sender {
    [[ConsoliAdsMediation sharedInstance] showBanner:[AppDelegate sharedInstance].configuration.selectedPlaceholder bannerView:bannerView viewController:self];

}

- (void)onBannerAdLoaded:(CAMediatedBannerView *)bannerView {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
    [bannerView removeFromSuperview];
    [self.view addSubview:bannerView];
    [self setBannerViewPosition:bannerView];
}

- (void)onBannerAdLoadFailed:(CAMediatedBannerView*)bannerView {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onBannerAdClicked {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onBannerAdRefreshEvent {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

#pragma positionBannerView

- (void)setBannerViewPosition:(UIView*)bannerView {

    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    bannerView.backgroundColor = UIColor.redColor;
    [self setWidthHeight:bannerView];
    if (@available(ios 11.0, *)) {
        [self positionBannerViewToSafeArea:bannerView];
    }
    else {
        [self positionBannerView:bannerView];
    }
}

- (void)positionBannerViewToSafeArea:(UIView*)bannerView NS_AVAILABLE_IOS(11.0) {
    
    UILayoutGuide *guide = self.view.safeAreaLayoutGuide;
    
    [NSLayoutConstraint activateConstraints:@[
        [bannerView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor],
        [bannerView.centerXAnchor constraintEqualToAnchor:guide.centerXAnchor]
    ]];
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

- (void)setWidthHeight:(UIView*)bannerView {
    
    [bannerView addConstraint:[NSLayoutConstraint constraintWithItem:bannerView
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute: NSLayoutAttributeNotAnAttribute
                                                          multiplier:1
                                                            constant:bannerView.frame.size.width]];
    
    // Height constraint
    [bannerView addConstraint:[NSLayoutConstraint constraintWithItem:bannerView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute: NSLayoutAttributeNotAnAttribute
                                                          multiplier:1
                                                            constant:bannerView.frame.size.height]];
    
}

@end
