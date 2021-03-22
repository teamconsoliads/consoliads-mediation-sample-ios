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
#import "CAIconAdView.h"
#import "AppDelegate.h"
#import "Config.h"
#import "CAMediationConstants.h"

@interface ViewController () <ConsoliAdsMediationDelegate, ConsoliAdsMediationRewardedAdDelegate, ConsoliAdsMediationInterstitialAdDelegate, ConsoliAdsMediationIconAdDelegate, CANativeAdRequestDelegate,CAMediatedBannerAdViewDelegate, ConsoliAdsMediationInAppDelegate> {
    BOOL userConsent;
    BOOL devMode;
    int iconAdXAxis;
    int iconAdYAxis;
    NSMutableArray *iconAdViewArray;
    NSString *myTag;
    CAIconAdView *iconAdView;
    NSArray *nativePlaceHolders;
    CGRect iconAdframe;
}

@property (weak, nonatomic) IBOutlet MediationNativeAdView *nativeAdView;
@property(nonatomic, strong) CAMediatedBannerView *bannerView;

@end

@interface ViewController (NativeAdMediation) <CANativeAdRequestDelegate>

- (void)showNativeAd;

@end

@implementation ViewController

@synthesize  nativeAdPlaceholder;

- (void)viewDidLoad {
    [super viewDidLoad];
    myTag = @"!--QA-Testing-Listner--!";
    userConsent = true;
    devMode = NO;
    [self updateUserConsentUI];
    [self updateDevModeUI];
    iconAdframe = CGRectMake(250, 180.0 *([UIScreen mainScreen].bounds.size.height / 750.0), 100, 100);
    iconAdViewArray = [NSMutableArray new];

    self.pickerView.dataSource = self;
    nativePlaceHolders = @[@"MainMenu",
                           @"SelectionScene",
                           @"FinalScene",
                           @"OnSuccess",
                           @"OnFailure",
                           @"OnPause",
                           @"StoreScene",
                           @"Gameplay",
                           @"MidScene1",
                           @"MidScene2",
                           @"MidScene3",
                           @"AppExit",
                           @"LoadingScene1",
                           @"LoadingScene2",
                           @"onReward",
                           @"SmartoScene",
                           @"Activity1",
                           @"Activity2",
                           @"Activity3",
                           @"Activity4",
                           @"Activity5",
                           @"OptionA",
                           @"OptionB",
                           @"OptionC",
                           @"Settings",
                           @"About" ,
                           @"Default"];
    self.pickerView.hidden = YES;
    [AppDelegate sharedInstance].configuration.selectedPlaceholder = Default;
    [self.placeHolder setTitle:nativePlaceHolders[(Default - 1)] forState:UIControlStateNormal];
    
    [[ConsoliAdsMediation sharedInstance] setDelegate:self];
    [[ConsoliAdsMediation sharedInstance] setInAppAdDelegate:self];
    [[ConsoliAdsMediation sharedInstance] setRewardedAdDelegate:self];
    [[ConsoliAdsMediation sharedInstance] setInterstitialAdDelegate:self];
    
    iconAdView = [[CAIconAdView alloc] initWithFrame:iconAdframe];
    iconAdView.rootViewController = self;
    [iconAdView setAnimationType:[AppDelegate sharedInstance].configuration.iconAdAnimationType animationDuration:NO];
    [self.view addSubview:iconAdView];
    [self.view bringSubviewToFront:iconAdView];
    
    self.bannerView = [[CAMediatedBannerView alloc] init];
    self.bannerView.delegate  = self;
    [self.pickerView selectRow:[nativePlaceHolders indexOfObject:@"Default"] inComponent:0 animated:NO];
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
            [self  showSingleIconAds:sender];
            break;
        case 7:
            [self  hideSingleIconAd];
            break;
        case 8:
            [self  showNativeAd];
            break;
        case 9:
            break;
        case 10:
            userConsent = !userConsent;
            [self  updateUserConsentUI];
            break;
            
        case 11:
            // show multiple icon ads
            [self showMultiIconAds:sender];
            break;
            
        case 12:
            // hide multiple icon ads
            [self hideMultipleIconAd];
            
            break;
            
        case 14:
            [self loadInterstitialAds];
            break;
            
        case 15:
            devMode = !devMode;
            [self updateDevModeUI];
            break;
        case 16:
            self.pickerView.hidden = NO;
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
    // MARK: set its value to YES to enable devmode
    [[ConsoliAdsMediation sharedInstance] initialize:devMode boolUserConsent:userConsent viewController:self userSignature:@"123456778"];
}

-(void)updateUserConsentUI {
    
    if (!userConsent) {
        UIImage *btnImage = [UIImage imageNamed:@"uncheck.png"];
        [_userConsentOutlet setImage:btnImage forState: UIControlStateNormal];
    }
    else {
        UIImage *btnImage = [UIImage imageNamed:@"check.png"];
        [_userConsentOutlet setImage:btnImage forState: UIControlStateNormal];
    }
}

-(void)updateDevModeUI {
    
    if (!devMode) {
        UIImage *btnImage = [UIImage imageNamed:@"uncheck.png"];
        [_devModeOutlet setImage:btnImage forState: UIControlStateNormal];
    }
    else {
        UIImage *btnImage = [UIImage imageNamed:@"check.png"];
        [_devModeOutlet setImage:btnImage forState: UIControlStateNormal];
    }
}

-(void) loadInterstitialAds {
    [[ConsoliAdsMediation sharedInstance] loadInterstitial:[AppDelegate sharedInstance].configuration.selectedPlaceholder];
}

- (void)showInterstitialAds {
    [[ConsoliAdsMediation sharedInstance]showInterstitial:[AppDelegate sharedInstance].configuration.selectedPlaceholder viewController:self];
}

-(void) loadRewardedAds {
    [[ConsoliAdsMediation sharedInstance] loadRewarded:[AppDelegate sharedInstance].configuration.selectedPlaceholder];
}

-(void)showRewardedAds {
    [[ConsoliAdsMediation sharedInstance]showRewardedVideo:[AppDelegate sharedInstance].configuration.selectedPlaceholder viewController:self];
}

- (void)showBannerAd {
    [[ConsoliAdsMediation sharedInstance] showBanner:[AppDelegate sharedInstance].configuration.selectedPlaceholder bannerView:self.bannerView viewController:self];
}

- (void)hideBannerAd {
    [self.bannerView destroyBanner];
}

- (void)showSingleIconAds:(UIButton *)sender {
    
    if (iconAdView == nil) {
        iconAdView = [[CAIconAdView alloc] initWithFrame:iconAdframe];
        iconAdView.rootViewController = self;
        [iconAdView setAnimationType:[AppDelegate sharedInstance].configuration.iconAdAnimationType animationDuration:NO];
        [self.view addSubview:iconAdView];
    }
    [[ConsoliAdsMediation sharedInstance] showIconAd:[AppDelegate sharedInstance].configuration.selectedPlaceholder iconAdView:iconAdView delegate:self];
}

- (void)hideSingleIconAd {
    
    [iconAdView destroy];
    iconAdView = nil;
}


- (void)showMultiIconAds:(UIButton *)sender  {
    
    CAIconAdView *newIconAdView = [[CAIconAdView alloc] init];
    newIconAdView.rootViewController = self;
    [newIconAdView setAnimationType:[AppDelegate sharedInstance].configuration.iconAdAnimationType animationDuration:NO];
    
    if (newIconAdView != nil) {
        CGRect frame = newIconAdView.frame;
        frame.origin.x = iconAdXAxis;
        frame.origin.y = iconAdYAxis;
        newIconAdView.frame = frame;
        iconAdXAxis += 110;
        if (iconAdXAxis >= sender.superview.bounds.size.width) {
            iconAdYAxis += 110;
            iconAdXAxis = 0;
        }
    }
    
    
    if (newIconAdView != nil) {
        [self.iconAdViewController addSubview:newIconAdView];
        [iconAdViewArray addObject:newIconAdView];
    }
    
    [[ConsoliAdsMediation sharedInstance] showIconAd:[AppDelegate sharedInstance].configuration.selectedPlaceholder iconAdView:newIconAdView delegate:self];
    
}

- (void)hideMultipleIconAd  {
    
    CAIconAdView *iconView = [iconAdViewArray lastObject];
    [iconView removeFromSuperview];
    [iconView destroy];
    [iconAdViewArray removeLastObject];
}

#pragma mark ConsoliAdsMediationDelegate

- (void)onConsoliAdsInitializationSuccess:(BOOL)status {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

#pragma mark ConsoliAdsMediationInterstitialAdDelegate

- (void)onInterstitialAdLoaded:(PlaceholderName)placeholderName {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onInterstitialAdFailToLoad:(PlaceholderName)placeholderName {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onInterstitialAdShown:(PlaceholderName)placeholderName {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onInterstitialAdFailedToShow:(PlaceholderName)placeholderName {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onInterstitialAdClicked {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onInterstitialAdClosed:(PlaceholderName)placeholderName { 
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

#pragma mark ConsoliAdsMediationRewardedAdDelegate

- (void)onRewardedVideoAdLoaded:(PlaceholderName)placeholderName {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdFailToLoad:(PlaceholderName)placeholderName {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdShown:(PlaceholderName)placeholderName {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdFailToShow:(PlaceholderName)placeholderName {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdClicked {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdClosed:(PlaceholderName)placeholderName { 
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onRewardedVideoAdCompleted:(PlaceholderName)placeholderName { 
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

#pragma mark CAMediatedBannerAdViewDelegate

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
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)onBannerAdRefreshEvent {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark ConsoliAdsMediationIconAdDelegate

-(void)onIconAdShownEvent {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

-(void) onIconAdFailedToShownEvent {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
    
}
-(void) onIconAdRefreshEvent {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
    
}
-(void) onIconAdClosedEvent {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
    
}
-(void) onIconAdClickEvent {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

#pragma mark ConsoliAdsMediationInAppDelegate

- (void)onInAppPurchaseFailed:(CAInAppError*)error {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}
- (void)onInAppPurchaseSuccess:(CAInAppDetails*)product {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onInAppPurchaseRestored:(CAInAppDetails *)product { 
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
    
    [NSLayoutConstraint activateConstraints:@[
        [bannerView.centerXAnchor constraintEqualToAnchor:self.bannerAdPlaceHolderView.centerXAnchor],
        [bannerView.centerYAnchor constraintEqualToAnchor:self.bannerAdPlaceHolderView.centerYAnchor]
    ]];
}

- (void)positionBannerView:(UIView *)bannerView {
    
    [self.view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:bannerView
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.bannerAdPlaceHolderView
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:bannerView
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.bannerAdPlaceHolderView
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
                                                            constant:self.bannerView.frame.size.width]];
    
    // Height constraint
    [bannerView addConstraint:[NSLayoutConstraint constraintWithItem:bannerView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute: NSLayoutAttributeNotAnAttribute
                                                          multiplier:1
                                                            constant:self.bannerView.frame.size.height]];
    
}

#pragma mark
#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender NS_AVAILABLE_IOS(5_0) {
}

- (IBAction)userConsentOutlet:(UIButton *)sender {
}

#pragma
#pragma mark UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return nativePlaceHolders.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return nativePlaceHolders[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.pickerView.hidden = YES;
    [self.placeHolder setTitle:nativePlaceHolders[row] forState:UIControlStateNormal];
    
    PlaceholderName placeholderName = (PlaceholderName)(row + 1);
    [AppDelegate sharedInstance].configuration.selectedPlaceholder = placeholderName;
}

@end

@implementation ViewController (NativeAdMediation)

- (void)showNativeAd {
    [[ConsoliAdsMediation sharedInstance] loadNativeAdInViewController:self placeholder:[AppDelegate sharedInstance].configuration.selectedPlaceholder delegate:self];
}

- (void)onNativeAdLoaded:(CAMediatedNativeAd *)nativeAd {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
    [nativeAd registerViewForInteractionWithNativeAdView:self.nativeAdView];
}

- (void)onNativeAdLoadFailed {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
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
