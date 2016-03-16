//
//  CNLLoadingButton.m
//  CNLLoadingButtonDemo
//
//  Created by 林雅茹 on 15/9/11.
//  Copyright (c) 2015年 linyr. All rights reserved.
//

#import "CNLLoadingButton.h"
#import "ViewUtils.h"

const CGFloat kSpaceWidth = 5.0;

@interface CNLLoadingButton ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (assign, nonatomic) BOOL isLoading;

@property (copy, nonatomic) NSString *loadingText;

@end


@implementation CNLLoadingButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        [self personalizationDefaultInit];
    }
    return self;
}

- (void)awakeFromNib
{
    self.clipsToBounds = YES;
    [self personalizationDefaultInit];
}

- (void)personalizationDefaultInit
{
    self.loadingButtonAlignment = CNLLoadingButtonAlignmentRight;
    self.loadingButtonEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
}

#pragma mark - layout subviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 正在加载中，并且当前显示的是禁用状态下的提示语
    if (self.isLoading && [self.titleLabel.text isEqualToString:self.loadingText]) {
        [self.activityIndicatorView startAnimating];
        switch (self.loadingButtonAlignment) {
            case CNLLoadingButtonAlignmentLeft: {
                [self layoutSubviewsWhenLoadingButtonAlignmentLeft];
            }
                break;
            case CNLLoadingButtonAlignmentRight: {
                [self layoutSubviewsWhenLoadingButtonAlignmentRight];
            }
                break;
            case CNLLoadingButtonAlignmentCenter: {
                [self layoutSubviewsWhenLoadingButtonAlignmentCenter];
            }
                break;
            default:
                break;
        }
    } else {
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
            CGFloat maxTitleWidth = self.width - self.loadingButtonEdgeInsets.left - self.loadingButtonEdgeInsets.right;
            CGFloat realTitleWidth = [self.titleLabel sizeThatFits:CGSizeMake(maxTitleWidth, CGFLOAT_MAX)].width;
            self.titleLabel.width = maxTitleWidth < realTitleWidth ? maxTitleWidth : realTitleWidth;
            self.titleLabel.left = (self.width - self.titleLabel.width) / 2.0;
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
            CGFloat maxTitleWidth = self.width - self.loadingButtonEdgeInsets.left - self.loadingButtonEdgeInsets.right;
            CGFloat realTitleWidth = [self.titleLabel sizeThatFits:CGSizeMake(maxTitleWidth, CGFLOAT_MAX)].width;
            self.titleLabel.width = maxTitleWidth < realTitleWidth ? maxTitleWidth : realTitleWidth;
            self.titleLabel.left = (self.width - self.titleLabel.width) / 2.0;
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
    [self startLoadingWithLoadingText:nil];
}

- (void)startLoadingWithLoadingText:(NSString *)loadingText
{
    if (!self.isLoading) {
        if (loadingText.length != 0 && self.loadingButtonAlignment != CNLLoadingButtonAlignmentCenter) {
            self.loadingText = loadingText;
        } else {
            if (self.loadingButtonAlignment == CNLLoadingButtonAlignmentCenter) {
                self.loadingText = @" ";
            } else {
                // 默认显示正常状态下的提示语
                self.loadingText = [self titleForState:UIControlStateNormal];
            }
        }
        [self setTitle:self.loadingText forState:UIControlStateDisabled];
        self.isLoading = YES;
        self.enabled = NO;

    }
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
    if (self.isLoading) {
        // 停止loading，回到loading前的可用状态
        if (normalText.length != 0) {
            [self setTitle:normalText forState:UIControlStateNormal];
        }
        self.isLoading = NO;
        // 停止加载回到loading前的状态，loading前是可用的
        self.enabled = YES;
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

- (void)setLoadingButtonAlignment:(CNLLoadingButtonAlignment)loadingButtonAlignment
{
    //    if (loadingButtonAlignment == CNLLoadingButtonAlignmentCenter) {
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
