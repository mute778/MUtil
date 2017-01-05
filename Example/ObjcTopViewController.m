//
//  ObjcTopViewController.m
//  MUtil
//
//  Created by 宮田　寿康 on 2017/01/05.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

#import "ObjcTopViewController.h"
#import "MUtil-Swift.h"

@interface ObjcTopViewController ()

@end

@implementation ObjcTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testAction:(UIButton *)sender {
    NSString *version = [MUtil getAppVersion];
    NSLog(@"%@", version);
}


@end
