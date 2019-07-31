//
//  MobfoxNativeAdViewController.h
//  LeadboltSDKSampleApp
//
//  Created by Jay on 1/12/2015.
//  Copyright © 2015 Leadbolt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobfoxNativeAdViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *discriptionLabel;
@property (nonatomic, strong) IBOutlet UIImageView *ImageView;
@property (nonatomic, strong) IBOutlet UIButton *ctaButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UIImageView *iconImageView;

@end

