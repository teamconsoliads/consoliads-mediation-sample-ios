//
//  ViewController.h
//  ObjectiveC-AdNetworks
//
//  Created by rehmanaslam on 12/10/2018.
//  Copyright © 2018 rehmanaslam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *nativeAdPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *iconAdViewController;
@property (weak, nonatomic) IBOutlet UIButton *userConsentOutlet;
@property (weak, nonatomic) IBOutlet UIView *bannerAdPlaceHolderView;
@property (weak, nonatomic) IBOutlet UIButton *devModeOutlet;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *placeHolder;


@end

