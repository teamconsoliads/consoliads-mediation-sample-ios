//
//  BannerAdsDemoListViewController.m
//  MediationTest
//
//  Created by FazalElahi on 22/01/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import "BannerAdsDemoListViewController.h"
#import "CAMediatedBannerView.h"
#import "MenuItemViewCell.h"
#import "ConsoliAdsMediation.h"
#import "MenuItem.h"

@interface BannerAdsDemoListViewController ()<UITableViewDelegate , UITableViewDataSource, CANativeAdRequestDelegate, CAMediatedBannerAdViewDelegate> {
    
    NSMutableArray* tableViewItems;
    NSMutableArray<CAMediatedBannerView*> *adsToLoad;
    NSMutableArray *loadStateForAds;
    float adViewHeight;
    NSString* myTag;
    
    NSArray *nativePlaceHolders;
    NativePlaceholderName selectedPlaceholder;

}

@end

@implementation BannerAdsDemoListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    myTag = @"!--QA-Testing-Listner--!";
    _adLoadingIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_adLoadingIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_adLoadingIndicator setColor:[UIColor orangeColor]];
    _adLoadingIndicator.center = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
    
    self.pickerView.dataSource = self;
    nativePlaceHolders = @[@"SmartoScene",
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
    selectedPlaceholder = Default;
    [self.placeHolder setTitle:nativePlaceHolders[11] forState:UIControlStateNormal];
    
  
    adViewHeight = 100.0f;
    self.title = @"Banner Ads ListView";
    
    tableViewItems = [NSMutableArray new];
    adsToLoad = [NSMutableArray new];
    loadStateForAds = [NSMutableArray new];
    
    selectedListIndex = 0;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuItem" bundle:nil] forCellReuseIdentifier:@"MenuItemViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BannerAd" bundle:nil] forCellReuseIdentifier:@"BannerViewCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 135;

    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableViewItems[indexPath.row] isKindOfClass:[CAMediatedBannerView class]]) {
        CAMediatedBannerView *bannerView = (CAMediatedBannerView*)tableViewItems[indexPath.row];
        CGFloat bannerHeight = bannerView.bounds.size.height;
        if (bannerHeight >= adViewHeight) {
            return bannerHeight;
        }
        return adViewHeight;
    }
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewItems.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if ([tableViewItems[indexPath.row] isKindOfClass:[CAMediatedBannerView class]]) {
        
        CAMediatedBannerView *bannerView = (CAMediatedBannerView*)tableViewItems[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BannerViewCell" forIndexPath:indexPath];
        
        for (UIView *subView in cell.contentView.subviews) {
            [subView removeFromSuperview];
        }
        
        [cell.contentView addSubview:bannerView];
        bannerView.center = cell.contentView.center;
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

- (IBAction)addBannerAdButtonPressed:(UIButton *)sender {
    
    [self.view endEditing:YES];
    selectedListIndex = [self convertTextToInteger:self.listViewTextField.text];    
    if (selectedListIndex < tableViewItems.count && selectedListIndex >= 0) {
        
        [self.view addSubview:_adLoadingIndicator];
        _addButton.enabled= NO;
        [_adLoadingIndicator startAnimating];
            
        CAMediatedBannerView *bannerView = [[CAMediatedBannerView alloc] init];
        bannerView.delegate = self;
//        [tableViewItems insertObject:bannerView atIndex:selectedListIndex];
        [adsToLoad addObject:bannerView];
        [loadStateForAds addObject:@(NO)];
//        [self loadNewAdInTableViewAtIndex:selectedListIndex item:bannerView];
        [[ConsoliAdsMediation sharedInstance] showBanner:selectedPlaceholder bannerView:bannerView viewController:self];
        
    }
    else {
        [self showErrorAlert:@"Value must in TableView items range"];
    }
}

- (void)showErrorAlert:(NSString*)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"warrning" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)loadNewAdInTableViewAtIndex:(int)index item:(id)item {
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

#pragma BannerViewDelegate

- (void)onBannerAdLoaded:(CAMediatedBannerView *)bannerView {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
    [self endIndicator];
       if ([adsToLoad containsObject:bannerView]) {
           [tableViewItems insertObject:bannerView atIndex:selectedListIndex];
           [self loadNewAdInTableViewAtIndex:selectedListIndex item:bannerView];
       }
}

- (void)onBannerAdLoadFailed:(CAMediatedBannerView*)bannerView {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
    [self endIndicator];
}

- (void)onBannerAdClicked {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

- (void)onBannerAdRefreshEvent {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
}

#pragma Utilities Methods

- (int)convertTextToInteger:(NSString*)text {
    
    NSScanner *scanner = [NSScanner scannerWithString:text];
    int result;
    BOOL hasInt = [scanner scanInt:&result];
    if (!hasInt) {
        result = 0;
    }
    return result;
}

- (void)dealloc {
    [self.adLoadingIndicator setHidden:YES];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

-(void)endIndicator{
    [_adLoadingIndicator stopAnimating];
    [_adLoadingIndicator removeFromSuperview];
    _addButton.enabled = YES;
}

- (IBAction)canvelButton:(UIButton *)sender {
    [self endIndicator];
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.pickerView.hidden = YES;
    [self.placeHolder setTitle:nativePlaceHolders[row] forState:UIControlStateNormal];

    switch (row) {
        case 0:
            selectedPlaceholder = SmartoScene;
            break;
        case 1:
            selectedPlaceholder = Activity1;
            break;
        case 2:
            selectedPlaceholder = Activity2;
            break;
        case 3:
            selectedPlaceholder = Activity3;
            break;
        case 4:
            selectedPlaceholder = Activity4;
            break;
        case 5:
            selectedPlaceholder = Activity5;
            break;
        case 6:
            selectedPlaceholder = OptionA;
            break;
        case 7:
            selectedPlaceholder = OptionB;
            break;
        case 8:
            selectedPlaceholder = OptionC;
            break;
        case 9:
            selectedPlaceholder = Settings;
            break;
        case 10:
            selectedPlaceholder = About;
            break;
        case 11:
            selectedPlaceholder = Default;
            break;
    }
}

- (IBAction)btnPlaceHolder:(UIButton *)sender {
    self.pickerView.hidden = NO;
}
@end
