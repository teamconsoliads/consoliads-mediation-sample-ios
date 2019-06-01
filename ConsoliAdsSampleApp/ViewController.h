//
//  ViewController.h
//  ObjectiveC-AdNetworks
//
//  Created by rehmanaslam on 12/10/2018.
//  Copyright © 2018 rehmanaslam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *indexField;
@property (weak, nonatomic) IBOutlet UIView *nativeAdPlaceholder;
@property (nonatomic) int checkStatus;
@property (weak, nonatomic) IBOutlet UIButton *userConsentOutlet;
//@property (nonatomic) UIView* view;

@end

