//
//  ChooseBannerViewController.m
//  ConsoliAdsSampleApp
//
//  Created by fazalWFH on 5/4/20.
//  Copyright © 2020 ConsoliAds. All rights reserved.
//

#import "ChooseBannerTableViewController.h"

@interface ChooseBannerTableViewController ()

@end

@implementation ChooseBannerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)dissmissVC:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
