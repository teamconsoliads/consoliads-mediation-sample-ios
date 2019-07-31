//
//  AppDelegate.h
//  MediationTest
//
//  Created by FazalElahi on 22/10/2018.
//  Copyright © 2018 ConsoliAds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Config;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) Config *configuration;

+ (AppDelegate*)sharedInstance;

@end

