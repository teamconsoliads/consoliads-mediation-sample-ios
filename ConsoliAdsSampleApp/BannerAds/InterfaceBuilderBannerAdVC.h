//
//  BannerAdInterfaceBuilder.h
//  ConsoliAdsSampleApp
//
//  Created by fazalWFH on 5/4/20.
//  Copyright © 2020 ConsoliAds. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CAMediatedBannerView;

@interface InterfaceBuilderBannerAdVC : UIViewController

@property (weak, nonatomic) IBOutlet CAMediatedBannerView *bannerView;

@end

NS_ASSUME_NONNULL_END
