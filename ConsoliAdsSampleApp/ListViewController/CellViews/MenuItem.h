//
//  MenuItem.h
//  MediationTest
//
//  Created by FazalElahi on 22/01/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuItem : NSObject

@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *menuDescription;
@property (nonatomic , strong) NSString *price;
@property (nonatomic , strong) NSString *category;
@property (nonatomic , strong) UIImage *photo;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
