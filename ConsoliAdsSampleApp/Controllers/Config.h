//
//  Config.h
//  MediationTest
//
//  Created by FazalElahi on 10/06/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsoliAdsIconAdSizes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Config : NSObject

@property (nonatomic , strong) NSString* productName ;
@property (nonatomic , strong) NSString* bundleIdentifier;
@property (nonatomic) CAIconAnimationTypes iconAdAnimationType;

@property (nonatomic) int sceneIndex;


@end

NS_ASSUME_NONNULL_END
