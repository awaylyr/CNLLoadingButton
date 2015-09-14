//
//  ViewController.m
//  CNLLoadingButton
//
//  Created by 林雅茹 on 15/9/14.
//  Copyright (c) 2015年 linyr. All rights reserved.
//

#import "CNLoadingButton.h"
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CNLoadingButton *leftLoadingButton;
@property (weak, nonatomic) IBOutlet CNLoadingButton *rightLoadingButton;
@property (weak, nonatomic) IBOutlet CNLoadingButton *centerLoadingButton;
@property (strong,nonatomic) NSTimer *timer;
@end

@implementation ViewController
- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.leftLoadingButton.loadingButtonAlignment = CNLoadingButtonAlignmentLeft;
    self.rightLoadingButton.loadingButtonAlignment = CNLoadingButtonAlignmentRight;
    self.centerLoadingButton.loadingButtonAlignment = CNLoadingButtonAlignmentCenter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)leftLoadingButtonMethod:(CNLoadingButton *)sender {
    self.leftLoadingButton.isHiddenActivityIndicatorWhenLoading = NO;
    [self.leftLoadingButton startLoadingWithLoadingText:@"你的影子剪不断断断"];
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateLoadingText) userInfo:nil repeats:YES];
    }
    
}

- (IBAction)rightLoadingButtonMethod:(CNLoadingButton *)sender {
    self.rightLoadingButton.isHiddenActivityIndicatorWhenLoading = NO;
    self.rightLoadingButton.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.rightLoadingButton startLoadingWithLoadingText:@"你的笑容已泛"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.rightLoadingButton endLoadingWithNormalText:@"秋天到啦"];
    });
}

- (IBAction)centerLoadingButtonMethod:(CNLoadingButton *)sender {
    self.centerLoadingButton.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.centerLoadingButton startLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.centerLoadingButton endLoadingWithNormalText:@"满城尽带黄金甲"];
    });
    
}


- (void)updateLoadingText
{
    static int i = 0;
    [self.leftLoadingButton updateLoadingText:[NSString stringWithFormat:@"更新%@",@(i++)]];
}
@end
