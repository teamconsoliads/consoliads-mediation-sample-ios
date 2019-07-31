//
//  LeadboltNativeAdViewController.h
//  LeadboltSDKSampleApp
//
//  Created by Jay on 1/12/2015.
//  Copyright © 2015 Leadbolt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeadboltNativeAdViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *callToActionButton;
@property (weak, nonatomic) IBOutlet UIImageView *mediaImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

