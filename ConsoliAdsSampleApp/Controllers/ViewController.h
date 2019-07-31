//
//  ViewController.h
//  ObjectiveC-AdNetworks
//
//  Created by rehmanaslam on 12/10/2018.
//  Copyright © 2018 rehmanaslam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *indexField;
@property (weak, nonatomic) IBOutlet UIView *nativeAdPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *consoliNativeAdPlaceHolder;
@property (nonatomic) int checkStatus;
@property (weak, nonatomic) IBOutlet UIButton *userConsentOutlet;
//@property (nonatomic) UIView* view;

@property (weak, nonatomic) IBOutlet FBMediaView *adIconView;
@property (weak, nonatomic) IBOutlet FBMediaView *adCoverMediaView;
@property (weak, nonatomic) IBOutlet UIButton *adCallToActionButton;
@property (weak, nonatomic) IBOutlet FBAdChoicesView *adChoicesView;
@property (weak, nonatomic) IBOutlet UILabel *adBodyLabel;
@property (weak, nonatomic) IBOutlet UIView *adUIView;
@property (weak, nonatomic) IBOutlet UILabel *sponsoredLabel;
@property (weak, nonatomic) IBOutlet UILabel *adSocialContextLabel;
@property (weak, nonatomic) IBOutlet UILabel *adTitleLabel;

@end

