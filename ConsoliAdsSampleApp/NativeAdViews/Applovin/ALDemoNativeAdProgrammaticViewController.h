//
//  ALDemoNativeAdProgrammaticViewController.h
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/24/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoBaseViewController.h"
#import "ALCarouselMediaView.h"

@interface ALDemoNativeAdProgrammaticViewController : ALDemoBaseViewController

@property (nonatomic, strong) IBOutlet UIImageView *appIcon;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *rating;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet ALCarouselMediaView *mediaView;
@property (nonatomic, strong) IBOutlet UIButton *ctaButton;
@property (nonatomic, weak) IBOutlet UIView *adViewContainer;

@end
