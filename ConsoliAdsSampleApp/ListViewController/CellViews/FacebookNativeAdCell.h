//
//  FacebookNativeAdCell.h
//  MediationTest
//
//  Created by FazalElahi on 22/01/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FBAudienceNetwork;

NS_ASSUME_NONNULL_BEGIN

@interface FacebookNativeAdCell : UITableViewCell

@property (nonatomic , weak) IBOutlet FBMediaView *adIconView;

@property (nonatomic , weak) IBOutlet FBMediaView *adMediaView;

@property (nonatomic , weak) IBOutlet FBAdChoicesView *adChoicesView;

@property (nonatomic , weak) IBOutlet UILabel *adTitleLabel;

@property (nonatomic , weak) IBOutlet UILabel *sponsoredLabel;

@property (nonatomic , weak) IBOutlet UILabel *adBodyLabel;

@property (nonatomic , weak) IBOutlet UILabel *adSocialContextLabel;

@property (nonatomic , weak) IBOutlet UIButton *adToCallButton;

@end

NS_ASSUME_NONNULL_END
