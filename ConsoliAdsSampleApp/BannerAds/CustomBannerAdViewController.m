//
//  CustomBannerAdViewController.m
//  ConsoliAdsSampleApp
//
//  Created by fazalWFH on 5/4/20.
//  Copyright © 2020 ConsoliAds. All rights reserved.
//

#import "CustomBannerAdViewController.h"
#import "ConsoliAdsMediation.h"
#import "CAMediatedBannerView.h"
#import "AppDelegate.h"
#import "Config.h"

@interface CustomBannerAdViewController () <CAMediatedBannerAdViewDelegate> {
    CAMediatedBannerView *bannerView;
    NSString *myTag;
}

@end

@implementation CustomBannerAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myTag = @"!--QA-Testing-Listner--!";
}

- (IBAction)showBanner:(UIButton*)sender {
    
    [self.view endEditing:YES];
//    [[ConsoliAdsMediation sharedInstance] destroyBannerView:bannerView];
    bannerView = [[CAMediatedBannerView alloc] init];
    [bannerView setCustomBannerSize:CGSizeMake(self.widthTextField.text.integerValue, self.heightTextField.text.integerValue)];
    bannerView.delegate = self;
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
