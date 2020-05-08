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
        _productName = @"iOS Native App";
        _bundleIdentifier = @"com.probook.Native";
        _sceneIndex = 1; // Don't change it, change it from UI
    }
    return self;
}

@end
