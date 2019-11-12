//
//  NativeAdsViewController.h
//  MediationTest
//
//  Created by FazalElahi on 22/01/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NativeAdsViewController : UIViewController {
    
    int selectedSceneIndex;
    int selectedListIndex;
}

@property (nonatomic , weak) IBOutlet UITableView* tableView;
@property (nonatomic , weak) IBOutlet UITextField* listViewTextField;
@property (nonatomic , weak) IBOutlet UITextField* sceneIndexTextField;


@end

NS_ASSUME_NONNULL_END
