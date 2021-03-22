//
//  IconAdTableViewController.m
//  ConsoliAdSDKSampleApplication
//
//  Created by fazalWFH on 7/24/20.
//  Copyright © 2020 FazalElahi. All rights reserved.
//

#import "IconAdsDemoListViewController.h"
#import "ConsoliAdsIconAdSizes.h"
#import "CAIconAdView.h"
#import "MenuItemViewCell.h"
#import "ConsoliAdsMediation.h"
#import "MenuItem.h"
#import "ConsoliAdsMediationIconAdDelegate.h"
#import "MenuItemIconAd.h"
#import "AppDelegate.h"
#import "Config.h"

@interface IconAdsDemoListViewController ()<ConsoliAdsMediationIconAdDelegate> {
    //    int counter;
    NSString* myTag;
    NSArray *nativePlaceHolders;
    PlaceholderName selectedPlaceholder;

}

@property (strong, nonatomic) NSMutableArray* tableViewItems;
@property (strong, nonatomic) NSMutableArray<CAIconAdView*> *adsToLoad;
@property (strong, nonatomic) NSMutableArray *loadStateForAds;

@end

@implementation IconAdsDemoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    counter = 3;
    myTag = @"!--QA-Testing-Listner--!";
    selectedListIndex = 0;
    self.adsToLoad = [NSMutableArray new];
    [self setupMenuTableItems];
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuItem" bundle:nil] forCellReuseIdentifier:@"MenuItem"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuItem_IconAd" bundle:nil] forCellReuseIdentifier:@"MenuItem_IconAd"];
    
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
}

- (IBAction)addIconAdButtonPressed:(UIButton *)sender {
    [self.view endEditing:YES];
    selectedListIndex = [self convertTextToInteger:self.listViewTextField.text];
    
    CAIconAdView *newIconAdView = [[CAIconAdView alloc] init];
    newIconAdView.rootViewController = self;
    [self.adsToLoad addObject:newIconAdView];
    [[ConsoliAdsMediation sharedInstance] showIconAd:selectedPlaceholder iconAdView:newIconAdView delegate:self];
}

- (IBAction)cancelButton:(UIButton *)sender {
    [self.view endEditing:YES];
}

- (void)onIconAdShownEvent {
    
    CAIconAdView *newIconAdView = [self.adsToLoad firstObject];
    [self.adsToLoad removeObject:newIconAdView];
    
    if (newIconAdView != nil) {
        
        CGRect frame = newIconAdView.frame;
        frame.origin.x = 10;
        frame.origin.y = 10;
        newIconAdView.frame = frame;
        
        MenuItemIconAd *item = [[MenuItemIconAd alloc] init];
        if (item) {
            item.name = @"";
            item.iconAdView = newIconAdView;
        }
        [self.tableViewItems insertObject:item atIndex:selectedListIndex];
        if (@available(iOS 11.0, *)) {
            [self.tableView performBatchUpdates:^{
                [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:selectedListIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                //                counter +=1;
            } completion:nil];
        } else {
            // Fallback on earlier versions
        }
    }
}

-(void) onIconAdFailedToShownEvent {
    NSLog(@"%@ : %s",myTag, __PRETTY_FUNCTION__);
    CAIconAdView *newIconAdView = [self.adsToLoad firstObject];
    [self.adsToLoad removeObject:newIconAdView];
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

- (void)setupMenuTableItems {
    self.tableViewItems = [NSMutableArray arrayWithCapacity:100];
    for (int i = 0; i< 100; i++) {
        MenuItem *item = [[MenuItem alloc] init];
        item.name = [NSString stringWithFormat:@"Label.. %d",i];
        [self.tableViewItems addObject:item];
    }
    [self.tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MenuItemViewCell *cell = nil;
    if ([self.tableViewItems[indexPath.row] isKindOfClass:[MenuItemIconAd class]]) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"MenuItem_IconAd" forIndexPath:indexPath];
        MenuItemIconAd *menuItem = (MenuItemIconAd*)self.tableViewItems[indexPath.row];
        
        for (UIView *subView in cell.contentView.subviews) {
            if ([subView isKindOfClass:[CAIconAdView class]]) {
                [subView removeFromSuperview];
                break;
            }
        }
        
        CAIconAdView *iconAdView = menuItem.iconAdView;
        
        if (iconAdView != nil) {
            [cell.contentView addSubview:iconAdView];
            [iconAdView setAnimationType:[AppDelegate sharedInstance].configuration.iconAdAnimationType animationDuration:YES];
        }
    }
    else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"MenuItem" forIndexPath:indexPath];
        MenuItem *menuItem = (MenuItem*)self.tableViewItems[indexPath.row];
        cell.nameLabel.text = menuItem.name;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewItems.count;
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

- (IBAction)unwindToViewControllerViewController:(UIStoryboardSegue *)segue {
    
}

@end
