//
//  NativeAdsViewController.m
//  MediationTest
//
//  Created by FazalElahi on 22/01/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import "NativeAdsViewController.h"
#import "ConsoliAdsMediation.h"
#import "FacebookNativeAdCell.h"
#import "MenuItemViewCell.h"
#import "MenuItem.h"
#import "NativeAdView.h"
#import "NativeAdBase.h"

@import GoogleMobileAds;
@import FBAudienceNetwork;

@interface NativeAdsViewController ()<UITableViewDelegate , UITableViewDataSource, ConsoliAdsMediationDelegate,
FBNativeAdDelegate, FBMediaViewDelegate> {
    
    NSMutableArray<GADUnifiedNativeAd*> *admobNativeAds;
    NSMutableArray<FBNativeAd*> *fbNativeAds;
    NSArray *adNetworksList;
    NSMutableArray* tableViewItems;
}

@end

typedef enum : NSUInteger {
    AdmobNativeAd,
    FacebookNativeAd,
    ConsoliAdsNativeAd,
} NativeAdType;


@implementation NativeAdsViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Native Ads ListView";
    adNetworksList = @[@"Admob Native Ad",@"Facebook Native Ad",@"ConsoliAds Native Ad"];
    
    admobNativeAds = [NSMutableArray new];
    fbNativeAds = [NSMutableArray new];
    tableViewItems = [NSMutableArray new];

    selectedSceneIndex = 0;
    selectedListIndex = 0;
    
    [[ConsoliAdsMediation sharedInstance] setDelegate:self];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuItem" bundle:nil] forCellReuseIdentifier:@"MenuItemViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NativeAdCellView" bundle:nil] forCellReuseIdentifier:@"NativeAdCellView"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UnifiedNativeAdCell" bundle:nil] forCellReuseIdentifier:@"UnifiedNativeAdCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FacebookNativeAdCell" bundle:nil] forCellReuseIdentifier:@"FacebookNativeAdCell"];
    
    [self addMenuItems];
    [self.tableView reloadData];
}

- (void)addMenuItems {
    
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"menuItemsJSON" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:path];
    NSArray *JSONObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dict in JSONObject) {
        MenuItem *item = [[MenuItem alloc] initWithDictionary:dict];
        [tableViewItems addObject:item];
    }
}

- (IBAction)addNativeAdButtonPressed:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    NSScanner *scanner = [NSScanner scannerWithString:self.listViewTextField.text];
    
    int result;
    
    BOOL hasInt = [scanner scanInt:&result];
    
    if (!hasInt) {
        result = 0;
    }
    result = (result +1) % tableViewItems.count;
    NSLog(@"List view Index: %d",result);
    selectedListIndex = result;

    [self addNativeAd];
}

- (void)addNativeAd {
    
    NSScanner *scanner = [NSScanner scannerWithString:self.sceneIndexTextField.text];
    int sceneIndexResult;
    BOOL sceneIndexHasInt = [scanner scanInt:&sceneIndexResult];
    
    if (sceneIndexHasInt && sceneIndexResult >= 0) {
        
        selectedSceneIndex = sceneIndexResult;
        NSLog(@"selectedSceneIndex : %d",selectedSceneIndex);

        [[ConsoliAdsMediation sharedInstance] addNativeAd:selectedSceneIndex];
    }
    else {
        [self showErrorAlert:@"Value must be an integer"];
    }
}

- (void)showErrorAlert:(NSString*)message {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"warrning" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)loadNewAdInTableViewAtIndex:(int)index item:(id)item {
    
    [tableViewItems insertObject:item atIndex:index];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableViewItems[indexPath.row] isKindOfClass:[FBNativeAd class]] || [tableViewItems[indexPath.row] isKindOfClass:[NativeAdBase class]]
        || [tableViewItems[indexPath.row] isKindOfClass:[GADUnifiedNativeAd class]]) {
        return 339;
    }
    return 140;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewItems.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if ([tableViewItems[indexPath.row] isKindOfClass:[GADUnifiedNativeAd class]]) {
        
        GADUnifiedNativeAd *nativeAd = (GADUnifiedNativeAd*)tableViewItems[indexPath.row];
        nativeAd.rootViewController = self;
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnifiedNativeAdCell" forIndexPath:indexPath];
        GADUnifiedNativeAdView *adView = (GADUnifiedNativeAdView*)cell.contentView.subviews[0];
        
        adView.nativeAd = nativeAd;
        ((UILabel*)adView.headlineView).text = nativeAd.headline;
        ((UILabel *)adView.bodyView).text = nativeAd.body;
        ((UILabel*)adView.priceView).text = nativeAd.price;
        ((UILabel*)adView.advertiserView).text = nativeAd.advertiser;

        if (nativeAd.starRating) {
            ((UILabel*)adView.starRatingView).text = nativeAd.starRating.description;
        }
        else
            
        [((UIButton *)adView.callToActionView)setTitle:nativeAd.callToAction forState:UIControlStateNormal];
        
        NSLayoutConstraint *heightConstraint;
        heightConstraint.active = NO;

        if (nativeAd.mediaContent.hasVideoContent) {
            
            if (nativeAd.mediaContent.aspectRatio > 0) {
                heightConstraint = [NSLayoutConstraint constraintWithItem:adView.mediaView
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:adView.mediaView
                                             attribute:NSLayoutAttributeWidth
                                            multiplier:(1 / nativeAd.mediaContent.aspectRatio)
                                              constant:0];
                heightConstraint.active = YES;
            }
        }
        
        ((UIImageView *)adView.iconView).image = nativeAd.icon.image;
        
        if (nativeAd.icon != nil) {
            adView.iconView.hidden = NO;
        } else {
            adView.iconView.hidden = YES;
        }
        
        ((UILabel *)adView.storeView).text = nativeAd.store;
        
        if (nativeAd.store != nil) {
            adView.storeView.hidden = NO;
        } else {
            adView.storeView.hidden = YES;
        }
        
        ((UILabel *)adView.priceView).text = nativeAd.price;
        
        if (nativeAd.price != nil) {
            adView.priceView.hidden = NO;
        } else {
            adView.priceView.hidden = YES;
        }
        
        ((UILabel *)adView.advertiserView).text = nativeAd.advertiser;
        
        if (nativeAd.advertiser != nil) {
            adView.advertiserView.hidden = NO;
        } else {
            adView.advertiserView.hidden = YES;
        }
        
        adView.callToActionView.userInteractionEnabled = NO;
        
        return cell;
    }
    else if ([tableViewItems[indexPath.row] isKindOfClass:[FBNativeAd class]]) {
        
        FBNativeAd *fbNativeAd = (FBNativeAd*)tableViewItems[indexPath.row];
        FacebookNativeAdCell *nativeAdCell = [tableView dequeueReusableCellWithIdentifier:@"FacebookNativeAdCell" forIndexPath:indexPath];
        
//        nativeAdCell.adMediaView.delegate = self;
        nativeAdCell.adTitleLabel.text = fbNativeAd.advertiserName;
        nativeAdCell.adBodyLabel.text = fbNativeAd.bodyText;
        nativeAdCell.adSocialContextLabel.text = fbNativeAd.socialContext;
        nativeAdCell.sponsoredLabel.text = fbNativeAd.sponsoredTranslation;
        
        if (fbNativeAd.callToAction) {
            nativeAdCell.adToCallButton.hidden = NO;
            [nativeAdCell.adToCallButton setTitle:fbNativeAd.callToAction forState:UIControlStateNormal];
            
        } else {
            nativeAdCell.adToCallButton.hidden = YES;
        }
        
        CGFloat gapToBorder = 9.0;
        CGFloat gapToCTAButton = 8.0;
        CGRect adBodyLabelFrame  = nativeAdCell.adBodyLabel.frame;
        adBodyLabelFrame.size.width = (nativeAdCell.adMediaView.bounds.size.width) - gapToBorder * 2;
        
        if (!(fbNativeAd.callToAction != nil)) {
            adBodyLabelFrame.size.width = (nativeAdCell.adMediaView.bounds.size.width) - gapToBorder * 2;
            
        }
        else {
            adBodyLabelFrame.size.width = (nativeAdCell.adMediaView.bounds.size.width) - gapToCTAButton - gapToBorder - ((nativeAdCell.adMediaView.bounds.size.width) - (nativeAdCell.adToCallButton.frame.origin.x));
        }
        
        nativeAdCell.adBodyLabel.frame = adBodyLabelFrame;
        
        nativeAdCell.adTitleLabel.nativeAdViewTag = FBNativeAdViewTagTitle;
        nativeAdCell.adBodyLabel.nativeAdViewTag = FBNativeAdViewTagBody;
        nativeAdCell.adSocialContextLabel.nativeAdViewTag = FBNativeAdViewTagSocialContext;
        nativeAdCell.adToCallButton.nativeAdViewTag = FBNativeAdViewTagCallToAction;
        
        NSArray<UIView*> *clickableViews = @[nativeAdCell.adIconView, nativeAdCell.adTitleLabel, nativeAdCell.adBodyLabel];
        
        [fbNativeAd registerViewForInteraction:nativeAdCell
                             mediaView:nativeAdCell.adMediaView
                              iconView:nativeAdCell.adIconView
                        viewController:nil
                        clickableViews:clickableViews];

        
        nativeAdCell.adChoicesView.nativeAd = fbNativeAd;
        nativeAdCell.adChoicesView.corner = UIRectCornerTopRight;
        nativeAdCell.adChoicesView.hidden = NO;
        
        return nativeAdCell;
    }
    else if ([tableViewItems[indexPath.row] isKindOfClass:[NativeAdBase class]]) {
        
        NativeAdBase *nativeAd = (NativeAdBase*)tableViewItems[indexPath.row];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NativeAdCellView" forIndexPath:indexPath];
        NativeAdView *nativeAdView = (NativeAdView*)cell.contentView.subviews[0];

        nativeAdView.nativeAd = nativeAd;
        nativeAdView.nativeAdTitle.text =  nativeAd.nativeAdTitle;
        nativeAdView.nativeAdSubtitle.text =  nativeAd.nativeAdSubtitle;
        nativeAdView.nativeAdDescription.text =  nativeAd.nativeAdDescription;
        
        if (nativeAd.callToActionButtonTitle != nil) {
            [nativeAdView.callToAction setTitle:nativeAd.callToActionButtonTitle forState:UIControlStateNormal];
        }
        return cell;
    }
    else if ([tableViewItems[indexPath.row] isKindOfClass:[MenuItem class]]) {
        
        MenuItem *menuItem = (MenuItem*)tableViewItems[indexPath.row];

        MenuItemViewCell *reusableMenuItemCell = [tableView dequeueReusableCellWithIdentifier:@"MenuItemViewCell" forIndexPath:indexPath];
        
        reusableMenuItemCell.nameLabel.text = menuItem.name;
        reusableMenuItemCell.descriptionLabel.text = menuItem.description;
        reusableMenuItemCell.priceLabel.text = menuItem.price;
        reusableMenuItemCell.categoryLabel.text = menuItem.category;
        reusableMenuItemCell.photoView.image = menuItem.photo;
        
        return reusableMenuItemCell;
    }
    else {
        NSLog(@"tableViewItems[indexPath.row] %@",[tableViewItems[indexPath.row] class]);
        return nil;
    }
}

- (IBAction)unwindToViewControllerViewController:(UIStoryboardSegue *)segue {
    //nothing goes here
}

- (void)onConsoliAdsInitializationSuccess:(BOOL)status {
    
}

- (void)onIconAdShown {
    
}

- (void)onInterstitialAdClicked {
    
}

- (void)onInterstitialAdShown {
    
}

- (void)onNativeAdFailedToLoad:(int)adNetworkName forIndex:(int)index {
    
}

- (void)onNativeAdLoaded:(int)adNetworkName forIndex:(int)index {
    
    if (adNetworkName == 27) {
       GADUnifiedNativeAd *admobNativeAd = [[ConsoliAdsMediation sharedInstance] getNativeAdSceneIndex:selectedSceneIndex atIndex:index];
        if (admobNativeAd) {
            [self loadNewAdInTableViewAtIndex:selectedListIndex item:admobNativeAd];
        }
    }
    else if (adNetworkName == 44) {
        FBNativeAd *fbNativeAd = [[ConsoliAdsMediation sharedInstance] getNativeAdSceneIndex:selectedSceneIndex atIndex:index];
        if (fbNativeAd) {
            [self loadNewAdInTableViewAtIndex:selectedListIndex item:fbNativeAd];
        }
    }
    else if (adNetworkName == 58) {
        NativeAdBase *caNativeAd = [[ConsoliAdsMediation sharedInstance] getNativeAdSceneIndex:selectedSceneIndex atIndex:index];
        if (caNativeAd) {
            [self loadNewAdInTableViewAtIndex:selectedListIndex item:caNativeAd];
        }
    }
    else {
        NSLog(@"error:%d",adNetworkName);
    }
}

- (void)onRewardedVideoAdClick {
    
}

- (void)onRewardedVideoAdCompleted {
    
}

- (void)onRewardedVideoAdShown {
    
}

- (void)onVideoAdClicked {
    
}

- (void)onVideoAdShown {
    
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (void)updateFocusIfNeeded {
    
}


@end
