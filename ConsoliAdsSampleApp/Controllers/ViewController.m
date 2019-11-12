//
//  ViewController.m
//  ObjectiveC-AdNetworks
//
//  Created by rehmanaslam on 12/10/2018.
//  Copyright © 2018 rehmanaslam. All rights reserved.
//

#import "ViewController.h"
#import "MediationNativeAdView.h"
#import "ConsoliAdsMediation.h"
#import "CANativeAdRequestDelegate.h"
#import "CAMediatedNativeAd.h"
#import <UIKit/UIKit.h>
#import "IconAdBase.h"
#import "IconAdView.h"
#import "AppDelegate.h"
#import "Config.h"

@interface ViewController () <ConsoliAdsMediationDelegate, ConsoliAdsMediationRewardedAdDelegate, ConsoliAdsMediationInterstitialAdDelegate, ConsoliAdsMediationBannerAdDelegate, ConsoliAdsMediationIconAdDelegate, CANativeAdRequestDelegate> {
    BOOL userConsent;
    int iconAdXAxis;
    int iconAdYAxis;
    NSMutableArray *iconAdViewArray;
    NSString *myTag;

}

@property (weak, nonatomic) IBOutlet MediationNativeAdView *nativeAdView;

@end

@implementation ViewController

@synthesize indexField, nativeAdPlaceholder, checkStatus;

- (void)viewDidLoad {
    [super viewDidLoad];
    indexField.text = @"0";
    myTag = @"!--QA-Testing-Listner--!";
    userConsent = true;
    iconAdViewArray = [NSMutableArray new];

    [ConsoliAdsMediation sharedInstance].productName = [AppDelegate sharedInstance].configuration.productName;
    [ConsoliAdsMediation sharedInstance].bundleIdentifier = [AppDelegate sharedInstance].configuration.bundleIdentifier;
    [[ConsoliAdsMediation sharedInstance] setDelegate:self];
    //    [[ConsoliAdsMediation sharedInstance] setRewardedAdDelegate:self];
    //    [[ConsoliAdsMediation sharedInstance] setInterstitialAdDelegate:self];
    //    [[ConsoliAdsMediation sharedInstance] setBannerAdDelegate:self];
    [[ConsoliAdsMediation sharedInstance] setIconAdDelegate:self];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:false];
}

- (IBAction)allConsoliFunctionalities:(UIButton *)sender {
    
    switch (sender.tag) {
            
        case 0:
            [self  initConsoliMediation];
            break;
        case 1:
            [self  showInterstitialAds];
            break;
        case 2:
            [self  loadRewardedAds];
            break;
        case 3:
            [self  showRewardedAds];
            break;
        case 4:
            [self  showBannerAd];
            break;
        case 5:
            [self  hideBannerAd];
            break;
        case 6:
            [self  showMultiIconAds:sender];
            break;
        case 7:
            [self  hideIconAd];
            break;
        case 9:
            break;
        case 10:
            [self  userConsentState];
            break;
            
        case 11:
            
            break;
            
        case 12:
            
            break;
            
        case 14:
            
            break;
            
        default:
            break;
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

-(void) initConsoliMediation {
    
    /*
     Optional Parameters:
     Param 1: userConsent - It's an optional parameter. If developer doesn't provide value then it's default value will be used which is "true" a Boolean value.
     Param 2: viewControler -  It's an optional parameter. If developer doesn't provide value then it's default value will be "nil". Banner will not be displayed, if developer calls show banner and ConsoliMediation mediation being initialized meanwhile.
     */
    
    [[ConsoliAdsMediation sharedInstance] initializeWithUserConsent:userConsent viewController:self];
}

-(void) userConsentState {
    
    checkStatus += 1;
    if (checkStatus == 1) {
        
        UIImage *btnImage = [UIImage imageNamed:@"uncheck.png"];
        [_userConsentOutlet setImage:btnImage forState: UIControlStateNormal];
        userConsent = NO;
    }
    
    else if (checkStatus == 2) {
        UIImage *btnImage = [UIImage imageNamed:@"check.png"];
        
        [_userConsentOutlet setImage:btnImage forState: UIControlStateNormal];
        userConsent = YES;
        checkStatus = 0;
    }
}

- (void)showInterstitialAds {
    
    int sceneIndex = [indexField.text intValue];
    [[ConsoliAdsMediation sharedInstance]showInterstitial:sceneIndex viewController:self];
}

-(void) loadRewardedAds {
    
    int sceneIndex = [indexField.text intValue];
    [[ConsoliAdsMediation sharedInstance] loadRewarded:sceneIndex];
}

-(void)showRewardedAds {
    
    NSString *str = indexField.text;
    int sceneIndex = [str intValue];
    [[ConsoliAdsMediation sharedInstance]showRewardedVideo:sceneIndex viewController:self];
}

- (void)showBannerAd {
    
    NSString *str = indexField.text;
    int sceneIndex = [str intValue];
    [[ConsoliAdsMediation sharedInstance] showBanner:sceneIndex viewController:self view:_bannerAdPlaceHolderView];
}

- (void)hideBannerAd {
    
    [[ConsoliAdsMediation sharedInstance] hideBanner];
}

- (void)showMultiIconAds:(UIButton *)sender  {
    
    int sceneIndex = [indexField.text intValue];
    
    IconAdBase *iconBase = (IconAdBase*)[[ConsoliAdsMediation sharedInstance] getIconAd:sceneIndex];
    IconAdView *view = [[IconAdView alloc] initWithAd:iconBase];
    
    if (view != nil) {
        CGRect frame = view.frame;
        frame.origin.x = iconAdXAxis;
        frame.origin.y = iconAdYAxis;
        view.frame = frame;
        iconAdXAxis += 70;
        if (iconAdXAxis >= sender.superview.bounds.size.width) {
            iconAdYAxis += 70;
            iconAdXAxis = 0;
        }
    }
    
    if (iconBase != nil) {
        [self.iconAdViewController addSubview:view];
        [iconAdViewArray addObject:view];
    }
}

- (void)hideIconAd  {
    
    UIView *view = [iconAdViewArray lastObject];
    [view removeFromSuperview];
    [iconAdViewArray removeLastObject];
}

- (void)onConsoliAdsInitializationSuccess:(BOOL)status {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onInterstitialAdShown {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}
- (void)onInterstitialAdClicked {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}
- (void)onInterstitialAdClosed {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}
- (void)onInterstitialAdFailedToShow {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onVideoAdShown {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onVideoAdFailedToShow {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onVideoAdClicked {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onVideoAdClosed {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdLoaded {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdFailToLoad {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdShown {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdCompleted {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdClicked {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdFailToShow {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdClosed {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onIconAdShown {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onIconAdFailedToShow {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onIconAdClosed {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onIconAdClicked {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onBannerAdShown {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onBannerAdFailToShow {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onBannerAdClosed {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onBannerAdClicked {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender NS_AVAILABLE_IOS(5_0) {
    
    int sceneIndex = [indexField.text intValue];
    [AppDelegate sharedInstance].configuration.sceneIndex = sceneIndex;

}

- (IBAction)showNativeAd:(id)sender {
    int index = [indexField.text intValue];
    [[ConsoliAdsMediation sharedInstance] loadNativeAdInViewController:self sceneIndex:index delegate:self];
}

- (void)onNativeAdLoaded:(CAMediatedNativeAd *)nativeAd {
    [nativeAd registerViewForInteractionWithNativeAdView:self.nativeAdView];
}

- (void)onNativeAdLoadFailed {
    
}


@end

@interface ViewController (NativeAdMediation) <CANativeAdRequestDelegate>

@end

@implementation ViewController (NativeAdMediation)

- (IBAction)showNativeAd:(id)sender {
    int index = [indexField.text intValue];
    [[ConsoliAdsMediation sharedInstance] loadNativeAdInViewController:self sceneIndex:index delegate:self];
}

- (void)onNativeAdLoaded:(CAMediatedNativeAd *)nativeAd {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
    [nativeAd registerViewForInteractionWithNativeAdView:self.nativeAdView];
}

- (void)onNativeAdClicked {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onNativeAdShown {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onNativeAdFailToShow {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}
- (void)onNativeAdClosed {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

@end

