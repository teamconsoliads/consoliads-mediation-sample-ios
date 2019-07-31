//
//  StartAppNativeAdViewController.h
//  LeadboltSDKSampleApp
//
//  Created by Jay on 1/12/2015.
//  Copyright © 2015 Leadbolt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartAppNativeAdViewController : UIViewController


@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *rating;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mediaImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

