//
//  NativeAdsViewController.m
//  MediationTest
//
//  Created by FazalElahi on 22/01/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import "NativeAdsViewController.h"
#import "MediationNativeAdView.h"
#import "MenuItemViewCell.h"
#import "ConsoliAdsMediation.h"
#import "CAMediatedNativeAd.h"
#import "MenuItem.h"
#import "NativeAdBase.h"

@interface NativeAdsViewController ()<UITableViewDelegate , UITableViewDataSource, CANativeAdRequestDelegate> {
    NSMutableArray* tableViewItems;
}

@end

@implementation NativeAdsViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Native Ads ListView";
    
    tableViewItems = [NSMutableArray new];

    selectedSceneIndex = 0;
    selectedListIndex = 0;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuItem" bundle:nil] forCellReuseIdentifier:@"MenuItemViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NativeAdCellView" bundle:nil] forCellReuseIdentifier:@"NativeAdCellView"];
    
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
    selectedListIndex = result;

    [self addNativeAd];
}

- (void)addNativeAd {
    
    NSScanner *scanner = [NSScanner scannerWithString:self.sceneIndexTextField.text];
    int sceneIndexResult;
    BOOL sceneIndexHasInt = [scanner scanInt:&sceneIndexResult];
    
    if (sceneIndexHasInt && sceneIndexResult >= 0) {
        
        selectedSceneIndex = sceneIndexResult;
        [[ConsoliAdsMediation sharedInstance] loadNativeAdInViewController:self sceneIndex:selectedSceneIndex delegate:self];
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
    if ([tableViewItems[indexPath.row] isKindOfClass:[CAMediatedNativeAd class]]) {
        return 339;
    }
    return 140;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewItems.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if ([tableViewItems[indexPath.row] isKindOfClass:[CAMediatedNativeAd class]]) {
        
        CAMediatedNativeAd *nativeAd = (CAMediatedNativeAd*)tableViewItems[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NativeAdCellView" forIndexPath:indexPath];
        MediationNativeAdView *nativeAdView = (MediationNativeAdView*)cell.contentView.subviews[0];
        [nativeAd registerViewForInteractionWithNativeAdView:nativeAdView];
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

- (void)onNativeAdLoadFailed {
    
}

- (void)onNativeAdLoaded:(CAMediatedNativeAd *)nativeAd {
    [self loadNewAdInTableViewAtIndex:selectedListIndex item:nativeAd];
}

- (IBAction)unwindToViewControllerViewController:(UIStoryboardSegue *)segue {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"%@, dealloc",NSStringFromSelector(_cmd));
}

@end
