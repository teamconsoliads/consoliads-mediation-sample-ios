//
//  MintegralNativeAdViewController.h
//  LeadboltSDKSampleApp
//
//  Created by Jay on 1/12/2015.
//  Copyright © 2015 Leadbolt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MTGSDK/MTGMediaView.h>
#import <MTGSDK/MTGAdChoicesView.h>

@interface MintegralNativeAdViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet MTGMediaView *mtgView;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet MTGAdChoicesView *adChoices;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *adCallButton;


@end

