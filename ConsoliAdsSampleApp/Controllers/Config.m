//
//  Config.m
//  MediationTest
//
//  Created by FazalElahi on 10/06/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import "Config.h"

@implementation Config

- (instancetype)init {
    if (self = [super init]) {
        _productName = @"Sample App";
        _bundleIdentifier = @"com.consoliads.sampleapp";
        _sceneIndex = 0; // Don't change it, change it from UI
    }
    return self;
}

@end
