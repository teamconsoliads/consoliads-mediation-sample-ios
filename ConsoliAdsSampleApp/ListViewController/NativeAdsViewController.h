//
//  NativeAdsViewController.h
//  MediationTest
//
//  Created by FazalElahi on 22/01/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NativeAdsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    int selectedListIndex;
}

@property (nonatomic , weak) IBOutlet UITableView* tableView;
@property (nonatomic , weak) IBOutlet UITextField* listViewTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *placeHolder;
- (IBAction)buttonSelectPlaceHolder:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
