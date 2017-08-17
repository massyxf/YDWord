//
//  YDRadiusView.h
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDRadiusView : UIView

/** 圆角,圆角有值时，下面的属性才会有意义*/
@property(nonatomic,assign)CGFloat radius;

/** 线宽,默认0.5*/
@property(nonatomic,assign)CGFloat lineWidth;

/** 线的颜色,默认graycolor*/
@property(nonatomic,strong)UIColor *lineColor;

@end
