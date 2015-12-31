//
//  CNLLoadingButton.h
//  CNLLoadingButtonDemo
//
//  Created by 林雅茹 on 15/9/11.
//  Copyright (c) 2015年 linyr. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CNLLoadingButtonAlignment) {
    CNLLoadingButtonAlignmentLeft,
    CNLLoadingButtonAlignmentRight,
    CNLLoadingButtonAlignmentCenter,// 不显示图片和文字，只显示菊花
};

@interface CNLLoadingButton : UIButton

- (void)startLoading;
- (void)startLoadingWithLoadingText:(NSString *)loadingText;
- (void)updateLoadingText:(NSString *)loadingText;
- (void)endLoading;
- (void)endLoadingWithNormalText:(NSString *)normalText;

//@property(nonatomic,assign)BOOL isHiddenImageWhenLoading;// default NO
//@property(nonatomic,assign)BOOL isHiddenTitleWhenLoading;// default NO

// when loading，the loadingText is too long，but button cannot show the full text，set activityIndicatorView hide，to show more text
@property(nonatomic,assign)BOOL isHiddenActivityIndicatorWhenLoading;// default NO
//
@property(nonatomic,assign)CNLLoadingButtonAlignment loadingButtonAlignment;// default left
//
@property(nonatomic,assign)UIEdgeInsets loadingButtonEdgeInsets;
//
@property(nonatomic,assign)UIActivityIndicatorViewStyle activityIndicatorViewStyle;



@end
