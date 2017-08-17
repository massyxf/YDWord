//
//  YDRadiusView.m
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDRadiusView.h"

@implementation YDRadiusView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithRect:rect];
    [self.backgroundColor setFill];
    [bgPath fill];
    
    if (self.radius > 0) {
//        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.radius];
//        [self.lineColor setStroke];
//        [path stroke];
        
        //使用下面的方法 圆角不会有锯齿
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGFloat width = CGRectGetWidth(rect);
        CGFloat height = CGRectGetHeight(rect);
        
        CGFloat middleX = width / 2.0 + 0.5;
        CGFloat middleY = height / 2.0 + 0.5;
        CGFloat maxX = width - 0.5;
        CGFloat maxY = height - 0.5;
        CGFloat minX = 0.5;
        CGFloat minY = 0.5;
        
        CGFloat radius = self.radius;
        
        CGContextMoveToPoint(context,middleX , minY);
        CGContextAddArcToPoint(context, minX, minY, minX, middleY, radius);
        CGContextAddArcToPoint(context, minX, maxY, middleX, maxY, radius);
        CGContextAddArcToPoint(context, maxX, maxY, maxX, middleY, radius);
        CGContextAddArcToPoint(context, maxX, minY, middleX, minY, radius);
        
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextClosePath(context);
        CGContextStrokePath(context);
    }
}

-(UIColor *)lineColor{
    if (!_lineColor) {
        _lineColor = [UIColor grayColor];
    }
    return _lineColor;
}

-(CGFloat)lineWidth{
    if (!(_lineWidth > 0)) {
        _lineWidth = 0.5;
    }
    return _lineWidth;
}

-(void)setFrame:(CGRect)frame{
    if (!CGRectEqualToRect(frame, self.frame)) {
        [super setFrame:frame];
        [self setNeedsDisplay];
    }
}

@end
