//
//  BannerAdsDemoListViewController.h
//  MediationTest
//
//  Created by FazalElahi on 22/01/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerAdsDemoListViewController : UIViewController {
    
    int selectedSceneIndex;
    int selectedListIndex;
}

@property (nonatomic , weak) IBOutlet UITableView* tableView;
@property (nonatomic , weak) IBOutlet UITextField* listViewTextField;
@property (nonatomic , weak) IBOutlet UITextField* sceneIndexTextField;
@property(nonatomic, strong) UIActivityIndicatorView * adLoadingIndicator;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
- (IBAction)canvelButton:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
