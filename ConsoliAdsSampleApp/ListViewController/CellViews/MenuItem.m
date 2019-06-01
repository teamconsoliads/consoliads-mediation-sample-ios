//
//  MenuItem.m
//  MediationTest
//
//  Created by FazalElahi on 22/01/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

- (instancetype)initWithName:(NSString *)name menuDescription:(NSString *)menuDescription price:(NSString *)price category:(NSString *)category photo:(UIImage *)photo {
    
    self = [super init];
    
    if (self) {
        // Initialize stored properties.
        _name = name;
        _menuDescription = menuDescription;
        _price = price;
        _category = category;
        _photo = photo;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *name = dictionary[@"name"];
    NSString *description = dictionary[@"description"];
    NSString *price = dictionary[@"price"];
    NSString *category = dictionary[@"category"];
    NSString *photoFileName = dictionary[@"photo"];
    UIImage *photo = [UIImage imageNamed:photoFileName];
    
    self = [self initWithName:name menuDescription:description price:price category:category photo:photo];
    
    return self;
}

@end
