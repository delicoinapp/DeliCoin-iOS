//
//  CoverViewController.m
//  DeliCoin
//
//  Created by Fabiola Ramirez on 18/10/15.
//  Copyright (c) 2015 Fabiola Ramirez. All rights reserved.
//

#import "CoverViewController.h"

@interface CoverViewController ()

@end




@implementation CoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goApp:(UIButton *)sender {
    
    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
