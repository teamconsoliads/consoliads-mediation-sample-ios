//
//  ViewController.m
//  ObjectiveC-AdNetworks
//
//  Created by rehmanaslam on 12/10/2018.
//  Copyright © 2018 rehmanaslam. All rights reserved.
//

#import "ViewController.h"
#import "ConsoliAdsMediation.h"
#import <UIKit/UIKit.h>
#import "IconAdBase.h"
#import "IconAdView.h"
#import "AppDelegate.h"
#import "Config.h"

@interface ViewController (){
    BOOL userConsent;
    int iconAdXAxis;
    int iconAdYAxis;
    NSMutableArray *iconAdViewArray;
}

@property (weak, nonatomic) IBOutlet UIView *iconView;

@end

@implementation ViewController

@synthesize indexField, nativeAdPlaceholder, checkStatus;

- (void)viewDidLoad {
    [super viewDidLoad];
    indexField.text = @"1";
    userConsent = true;
    iconAdViewArray = [NSMutableArray new];
    
    [ConsoliAdsMediation sharedInstance].productName  = [AppDelegate sharedInstance].configuration.productName;
    [ConsoliAdsMediation sharedInstance].bundleIdentifier = [AppDelegate sharedInstance].configuration.bundleIdentifier;

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
            
        case 1:
            [self  initConsoliMediation];
            break;
            
        case 2:
            [self  showInterstitialAds];
            break;
            
        case 3:
            
            [self  loadRewardedAds];
            break;
            
        case 4:
            
            [self  showRewardedAds];
            break;
            
        case 5:
            
            [self  showBannerAd];
            break;
            
        case 6:
            
            [self  hideBannerAd];
            break;
            
        case 7:
            [self showAdmobNativeAd];
            break;
            
        case 8:
            
            [self  showFacebookNativeAd];
            break;
        case 9:
            
            [self  hideNativeAd];
            break;
            
        case 10:
            
            [self  userConsentState];
            break;
            
        case 11:
            
            [self  showIconAd];
            break;
            
        case 12:
            
            [self  showMultiIconAds:sender];
            break;
            
        case 13:
            
            [self  hideIconAd];
            break;
            
        case 14:
            
            [self  showConsoliAdsNativeAd];
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

- (void)showInterstitialAds  {
    
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
    [[ConsoliAdsMediation sharedInstance]showBanner:sceneIndex viewController:self];
}

- (void)hideBannerAd {
    
    [[ConsoliAdsMediation sharedInstance] hideBanner];
}

-(void) showAdmobNativeAd {
    
    int sceneIndex = [indexField.text intValue];
    [[ConsoliAdsMediation sharedInstance] configureAdmobNativeAd:sceneIndex nativeAdPlaceholder:nativeAdPlaceholder viewController:self];
    [[ConsoliAdsMediation sharedInstance] ShowNativeAd:sceneIndex viewController:self];
}

- (void)showConsoliAdsNativeAd  {
    
    int sceneIndex = [indexField.text intValue];
    [[ConsoliAdsMediation sharedInstance] configureConsoliAdsNativeAd:sceneIndex nativeAdPlaceholder:nativeAdPlaceholder];
    [[ConsoliAdsMediation sharedInstance]ShowNativeAd:sceneIndex viewController:self];
}

-(void) showFacebookNativeAd  {
    
    int index = [indexField.text intValue];
    
//    [[ConsoliAdsMediation sharedInstance] configureFacebookNativeAd:index adSocialContextLabel:_adSocialContextLabel adBodyLabel:_adBodyLabel adTitleLabel:_adTitleLabel sponsoredLabel:_sponsoredLabel adUIView:_adUIView adActionButton:_adCallToActionButton viewController:self adIconView:_adIconView adCoverMediaView:_adCoverMediaView adChoicesView:_adChoicesView];
    
//    [[ConsoliAdsMediation sharedInstance] ShowNativeAd:index viewController:self];
}

-(void) hideNativeAd  {
    
    int sceneIndex = [indexField.text intValue];
    [[ConsoliAdsMediation sharedInstance] onDestroyForNativeAd:sceneIndex];
}

- (void)showIconAd  {
    
    int sceneIndex = [indexField.text intValue];
    [[ConsoliAdsMediation sharedInstance] configureConsoliAdsIconAd:sceneIndex iconAdPlaceholder:self.iconView];
    [[ConsoliAdsMediation sharedInstance] showIcon:sceneIndex viewController:self];
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
        [self.iconView addSubview:view];
        [iconAdViewArray addObject:view];
    }
}

- (void)hideIconAd  {
    
    UIView *view = [iconAdViewArray lastObject];
    [view removeFromSuperview];
    [iconAdViewArray removeLastObject];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender NS_AVAILABLE_IOS(5_0) {
    
    int sceneIndex = [indexField.text intValue];
    [AppDelegate sharedInstance].configuration.sceneIndex = sceneIndex;

}


@end

