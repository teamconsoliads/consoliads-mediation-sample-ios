//
//  MenuItemViewCell.h
//  MediationTest
//
//  Created by FazalElahi on 22/01/2019.
//  Copyright © 2019 ConsoliAds. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuItemViewCell : UITableViewCell

@property (nonatomic , weak) IBOutlet UILabel *nameLabel;
@property (nonatomic , weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic , weak) IBOutlet UILabel *priceLabel;
@property (nonatomic , weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic , weak) IBOutlet UIImageView *photoView;


@end

NS_ASSUME_NONNULL_END
