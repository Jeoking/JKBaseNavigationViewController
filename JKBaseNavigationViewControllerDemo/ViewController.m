//
//  ViewController.m
//  JKBaseNavigationViewControllerDemo
//
//  Created by JayKing on 17/7/29.
//  Copyright © 2017年 jeoking. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navCustomTitle = @"标题";
    
    __weak typeof(self) weak_self = self;
    [self addNavLeftBtnWithTitle:@"左键" icon:nil clickBlock:^{
        [weak_self showAlertWithTitle:@"点击左键" message:@"hello" buttonTitles:@[@"确定"] itemClickBlock:^(NSInteger index) {
            
        }];
    }];
    
    [self addNavRightBtnWithTitle:@"右键" icon:nil clickBlock:^{
        [weak_self showActionSheetWithTitle:@"点击右键" buttonTitles:@[@"第一行",@"第二行",@"第三行"] itemClickBlock:^(NSInteger index) {
            
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
