//
//  ViewController.m
//  JDQR
//
//  Created by raoyuanjie on 14-10-14.
//  Copyright (c) 2014年 raoyuanjie. All rights reserved.
//

#import "ViewController.h"
#import "QRController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)pushQR:(id)sender {
    QRController *qr=[[QRController alloc]init];
    [self.navigationController pushViewController:qr animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
