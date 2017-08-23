//
//  UIView+FrameExtention.m
//  YDialogues
//
//  Created by yxf on 2017/8/23.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "UIView+FrameExtention.h"

@implementation UIView (FrameExtention)

-(void)setYd_x:(CGFloat)yd_x{
    CGRect frame = self.frame;
    frame.origin.x = yd_x;
    self.frame = frame;
}

-(CGFloat)yd_x{
    return CGRectGetMinX(self.frame);
}

-(void)setYd_y:(CGFloat)yd_y{
    CGRect frame = self.frame;
    frame.origin.y = yd_y;
    self.frame = frame;
}
-(CGFloat)yd_y{
    return CGRectGetMinY(self.frame);
}

-(void)setYd_width:(CGFloat)yd_width{
    CGRect frame = self.frame;
    frame.size.width = yd_width;
    self.frame = frame;
}

-(CGFloat)yd_width{
    return CGRectGetWidth(self.frame);
}

-(void)setYd_height:(CGFloat)yd_height{
    CGRect frame = self.frame;
    frame.size.height = yd_height;
    self.frame = frame;
}

-(CGFloat)yd_height{
    return CGRectGetHeight(self.frame);
}

-(void)setYd_centerX:(CGFloat)yd_centerX{
    CGPoint center = self.center;
    center.x = yd_centerX;
    self.center = center;
}

-(CGFloat)yd_centerX{
    return self.center.x;
}

-(void)setYd_centerY:(CGFloat)yd_centerY{
    CGPoint center = self.center;
    center.y = yd_centerY;
    self.center = center;
}

-(CGFloat)yd_centerY{
    return self.center.y;
}

@end
