//
//  InitializeViewController.m
//  ConsoliAdsSampleApp
//
//  Created by FazalElahi on 26/08/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import "InitializeViewController.h"
#import "ConsoliAdsMediation.h"
#import "AppDelegate.h"
#import "Config.h"

@interface InitializeViewController ()

@end

@implementation InitializeViewController

@synthesize nativeAdPlaceholder;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[ConsoliAdsMediation sharedInstance] initializeWithUserConsent:true viewController:nil];
    // Do any additional setup after loading the view.
}

- (IBAction)dissmissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

-(IBAction)showAdmobNativeAd:(id)sender {
    int sceneIndex = [AppDelegate sharedInstance].configuration.sceneIndex;
    [[ConsoliAdsMediation sharedInstance] configureAdmobNativeAd:sceneIndex nativeAdPlaceholder:nativeAdPlaceholder viewController:self];
    [[ConsoliAdsMediation sharedInstance] ShowNativeAd:sceneIndex viewController:self];
}

- (IBAction)showConsoliAdsNativeAd:(id)sender {
    
    int sceneIndex = [AppDelegate sharedInstance].configuration.sceneIndex;
    [[ConsoliAdsMediation sharedInstance] configureConsoliAdsNativeAd:sceneIndex nativeAdPlaceholder:nativeAdPlaceholder];
    [[ConsoliAdsMediation sharedInstance] ShowNativeAd:sceneIndex viewController:self];
}

-(IBAction)hideNativeAd:(id)sender {
    int sceneIndex = [AppDelegate sharedInstance].configuration.sceneIndex;
    [[ConsoliAdsMediation sharedInstance] onDestroyForNativeAd:sceneIndex];
}

- (IBAction)showBannerAd:(id)sender {
    int sceneIndex = [AppDelegate sharedInstance].configuration.sceneIndex;
    [[ConsoliAdsMediation sharedInstance]showBanner:sceneIndex viewController:self];
}

- (IBAction)hideBannerAd:(id)sender {
    [[ConsoliAdsMediation sharedInstance] hideBanner];
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
