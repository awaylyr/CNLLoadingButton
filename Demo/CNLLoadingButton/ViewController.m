//
//  ViewController.m
//  CNLLoadingButton
//
//  Created by 林雅茹 on 15/9/14.
//  Copyright (c) 2015年 linyr. All rights reserved.
//

#import "CNLLoadingButton.h"
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CNLLoadingButton *leftLoadingButton;
@property (weak, nonatomic) IBOutlet CNLLoadingButton *rightLoadingButton;
@property (weak, nonatomic) IBOutlet CNLLoadingButton *centerLoadingButton;
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
    self.leftLoadingButton.loadingButtonAlignment = CNLLoadingButtonAlignmentLeft;
    self.rightLoadingButton.loadingButtonAlignment = CNLLoadingButtonAlignmentRight;
    self.centerLoadingButton.loadingButtonAlignment = CNLLoadingButtonAlignmentCenter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)leftLoadingButtonMethod:(CNLLoadingButton *)sender {
    self.leftLoadingButton.isHiddenActivityIndicatorWhenLoading = NO;
    [self.leftLoadingButton startLoadingWithLoadingText:@"你的影子剪不断断断"];
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateLoadingText) userInfo:nil repeats:YES];
    }
    
}

- (IBAction)rightLoadingButtonMethod:(CNLLoadingButton *)sender {
    self.rightLoadingButton.isHiddenActivityIndicatorWhenLoading = NO;
    self.rightLoadingButton.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.rightLoadingButton startLoadingWithLoadingText:@"你的笑容已泛"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.rightLoadingButton endLoadingWithNormalText:@"秋天到啦"];
    });
}

- (IBAction)centerLoadingButtonMethod:(CNLLoadingButton *)sender {
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
