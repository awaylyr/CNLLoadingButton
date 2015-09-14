//
//  CNLoadingButton.m
//  CNLoadingButtonDemo
//
//  Created by 林雅茹 on 15/9/11.
//  Copyright (c) 2015年 linyr. All rights reserved.
//

#import "CNLoadingButton.h"
#import <ViewUtils.h>

const CGFloat kSpaceWidth = 5.0;

@interface CNLoadingButton ()
// 菊花默认gray样式，要提供给外部创建？？？？？？？？？？？
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
// 是否要通过修改isLoading来修改button状态？？？？？？？？？
@property(assign,nonatomic)BOOL isLoading;
@end
@implementation CNLoadingButton

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"isLoading"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self registerKVO];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        [self registerKVO];
        [self personalizationDefaultInit];
    }
    return self;
}

- (void)awakeFromNib
{
    self.clipsToBounds = YES;
    [self personalizationDefaultInit];
}

- (void)registerKVO
{
    [self addObserver:self forKeyPath:@"isLoading" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)personalizationDefaultInit
{
    self.loadingButtonAlignment = CNLoadingButtonAlignmentRight;
    self.loadingButtonEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
}

#pragma mark - layout subviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isLoading && [self.titleLabel.text isEqualToString:[self titleForState:UIControlStateDisabled]]) {
        [self.activityIndicatorView startAnimating];
        switch (self.loadingButtonAlignment) {
            case CNLoadingButtonAlignmentLeft: {
                [self layoutSubviewsWhenLoadingButtonAlignmentLeft];
            }
                break;
            case CNLoadingButtonAlignmentRight: {
                [self layoutSubviewsWhenLoadingButtonAlignmentRight];
            }
                break;
            case CNLoadingButtonAlignmentCenter: {
                [self layoutSubviewsWhenLoadingButtonAlignmentCenter];
            }
                break;
            default:
                break;
        }
    } else if (!self.isLoading && [self.titleLabel.text isEqualToString:[self titleForState:UIControlStateNormal]]){
        [self setTitleEdgeInsets:UIEdgeInsetsZero];
        [self.activityIndicatorView stopAnimating];
    }
}

- (void)layoutSubviewsWhenLoadingButtonAlignmentLeft
{
    CGRect activityIndicatorViewFrame = self.activityIndicatorView.frame;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -(activityIndicatorViewFrame.size.width + kSpaceWidth))];
    CGFloat activityIndicatorViewX = 0.0;
    if (!CGRectEqualToRect(self.titleLabel.frame, CGRectZero) && !CGRectEqualToRect(self.imageView.frame, CGRectZero)) {
        activityIndicatorViewX = self.titleLabel.left < self.imageView.left ? self.titleLabel.left - kSpaceWidth : self.imageView.left - kSpaceWidth;
    } else if(CGRectEqualToRect(self.titleLabel.frame, CGRectZero)){
        activityIndicatorViewX = self.imageView.left - kSpaceWidth;
    } else {
        activityIndicatorViewX = self.titleLabel.left - kSpaceWidth;
    }
    activityIndicatorViewX = activityIndicatorViewX - activityIndicatorViewFrame.size.width;
    if ( activityIndicatorViewX - self.loadingButtonEdgeInsets.left < 0 ) {
        if (self.isHiddenActivityIndicatorWhenLoading) {
            self.titleLabel.left = self.loadingButtonEdgeInsets.left;
            self.titleLabel.width = self.width - self.loadingButtonEdgeInsets.left - self.loadingButtonEdgeInsets.right;
            [self.activityIndicatorView stopAnimating];
        } else {
            activityIndicatorViewFrame.origin.x = self.loadingButtonEdgeInsets.left ;
            activityIndicatorViewFrame.origin.y = (self.height - activityIndicatorViewFrame.size.height ) / 2.0;
            self.activityIndicatorView.frame = activityIndicatorViewFrame;
            self.titleLabel.left = self.loadingButtonEdgeInsets.left + activityIndicatorViewFrame.size.width + kSpaceWidth;
            self.titleLabel.width = self.width - self.titleLabel.left - self.loadingButtonEdgeInsets.right ;
        }
    } else {
        activityIndicatorViewFrame.origin.x = activityIndicatorViewX ;
        activityIndicatorViewFrame.origin.y = (self.height - activityIndicatorViewFrame.size.height ) / 2.0;
        self.activityIndicatorView.frame = activityIndicatorViewFrame;
    }
    
}

- (void)layoutSubviewsWhenLoadingButtonAlignmentRight
{
     CGRect activityIndicatorViewFrame = self.activityIndicatorView.frame;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(activityIndicatorViewFrame.size.width + kSpaceWidth), 0, 0)];
    CGFloat activityIndicatorViewX = 0.0;
    if (!CGRectEqualToRect(self.titleLabel.frame, CGRectZero) && !CGRectEqualToRect(self.imageView.frame, CGRectZero)) {
        activityIndicatorViewX = self.titleLabel.left > self.imageView.left ? self.titleLabel.left + self.titleLabel.width + kSpaceWidth : self.imageView.left + self.imageView.width + kSpaceWidth;
    } else if (CGRectEqualToRect(self.titleLabel.frame, CGRectZero)) {
        activityIndicatorViewX = self.imageView.left + self.imageView.width + kSpaceWidth;
    } else {
        activityIndicatorViewX = self.titleLabel.left + self.titleLabel.width + kSpaceWidth;
    }
    
    if ( activityIndicatorViewX + activityIndicatorViewFrame.size.width + self.loadingButtonEdgeInsets.right > self.width ) {
        if (self.isHiddenActivityIndicatorWhenLoading) {
            self.titleLabel.left = self.loadingButtonEdgeInsets.left;
            self.titleLabel.width = self.width - self.loadingButtonEdgeInsets.left - self.loadingButtonEdgeInsets.right;
            [self.activityIndicatorView stopAnimating];
        } else {
            activityIndicatorViewFrame.origin.x = self.width - self.loadingButtonEdgeInsets.right - activityIndicatorViewFrame.size.width;
            activityIndicatorViewFrame.origin.y = (self.height - activityIndicatorViewFrame.size.height ) / 2.0;
            self.activityIndicatorView.frame = activityIndicatorViewFrame;
            self.titleLabel.left = self.loadingButtonEdgeInsets.left;
            self.titleLabel.width = self.width - self.titleLabel.left - self.loadingButtonEdgeInsets.right - activityIndicatorViewFrame.size.width - kSpaceWidth;
        }
    } else {
        activityIndicatorViewFrame.origin.x = activityIndicatorViewX;
        activityIndicatorViewFrame.origin.y = (self.height - activityIndicatorViewFrame.size.height ) / 2.0;
        self.activityIndicatorView.frame = activityIndicatorViewFrame;
    }
}

- (void)layoutSubviewsWhenLoadingButtonAlignmentCenter
{
    CGRect activityIndicatorViewFrame = self.activityIndicatorView.frame;
    // 不显示图片和文字
    activityIndicatorViewFrame.origin = CGPointMake((self.width - activityIndicatorViewFrame.size.width) / 2.0, (self.height - activityIndicatorViewFrame.size.height ) / 2.0);
    self.activityIndicatorView.frame = activityIndicatorViewFrame;
}

#pragma mark - public method
- (void)startLoading
{
    [self startLoadingWithLoadingText:@" "];
}

- (void)startLoadingWithLoadingText:(NSString *)loadingText
{
    if (loadingText.length != 0 && self.loadingButtonAlignment != CNLoadingButtonAlignmentCenter) {
         [self setTitle:loadingText forState:UIControlStateDisabled];
    } else {
        if (self.loadingButtonAlignment == CNLoadingButtonAlignmentCenter) {
            [self setTitle:@" " forState:UIControlStateDisabled];
        } else {
            [self setTitle:[self titleForState:UIControlStateNormal] forState:UIControlStateDisabled];
        }
    }
   
    self.isLoading = YES;
}

- (void)updateLoadingText:(NSString *)loadingText
{
    [self setTitle:loadingText forState:UIControlStateDisabled];
}

- (void)endLoading
{
    [self endLoadingWithNormalText:nil];
}

- (void)endLoadingWithNormalText:(NSString *)normalText
{
    if (normalText.length != 0) {
        [self setTitle:normalText forState:UIControlStateNormal];
    }
    self.isLoading = NO;
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isLoading"]) {
        if ( [(NSNumber *)change[NSKeyValueChangeNewKey] boolValue]) {
            self.enabled = NO;
        } else {
            self.enabled = YES;
        }
    }
}

#pragma mark - getters and setters
- (UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.hidesWhenStopped = YES;
        [_activityIndicatorView stopAnimating];
        [self addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}

- (void)setLoadingButtonAlignment:(CNLoadingButtonAlignment)loadingButtonAlignment
{
//    if (loadingButtonAlignment == CNLoadingButtonAlignmentCenter) {
//        self.isHiddenTitleWhenLoading = YES;
//        self.isHiddenImageWhenLoading = YES;
//    }
    _loadingButtonAlignment = loadingButtonAlignment;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    self.activityIndicatorView.activityIndicatorViewStyle = _activityIndicatorViewStyle;
}
@end
