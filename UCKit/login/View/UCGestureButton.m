//
//  UCGestureButton.m
//  UCCategories
//
//  Created by Uncle.Chen on 1/5/16.
//  Copyright © 2016 Uncle.Chen. All rights reserved.
//

#import "UCGestureButton.h"

static CGFloat const __DEFAULTLINEWIDTH = 0.5f;
static CGFloat const __SELECTEDLINEWIDTH = 1.f;

@implementation UCGestureButton

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isHollowOut = YES;
        self.success = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat defalutLineWidth = __DEFAULTLINEWIDTH;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect frame = ({
        CGRectMake(__SELECTEDLINEWIDTH, __SELECTEDLINEWIDTH,
                   CGRectGetWidth(self.frame)-__SELECTEDLINEWIDTH*2,
                   CGRectGetHeight(self.frame)-__SELECTEDLINEWIDTH*2);
    }); // 空心圆frame
    
    // 镂空部分填充颜色
    if (self.isHollowOut) {
        CGContextSetRGBFillColor(context, 255.f/255.f, 255.f/255.f, 255.f/255.f, 1.f);
        CGContextAddEllipseInRect(context, frame);
        CGContextFillPath(context);
    } else {
        if (self.success) {
            CGContextSetRGBFillColor(context, 30.f/255.f, 175.f/255.f, 235.f/255.f, 0.3f);
        } else {
            CGContextSetRGBFillColor(context, 255.f/255.f, 0.f/255.f, 0.f/255.f, 0.3f);
        }
        CGContextAddEllipseInRect(context, frame);
        CGContextFillPath(context);
    }
    
    if (self.selected) {
        if (self.success) {
            CGContextSetRGBStrokeColor(context, 2.f/255.f, 174.f/255.f, 240.f/255.f, 1.f);// 空心圆边颜色
            CGContextSetRGBFillColor(context, 2.f/255.f, 174.f/255.f, 240.f/255.f, 1.f);// 中心圆颜色
        } else {
            CGContextSetRGBStrokeColor(context, 255.f/255.f, 0.f/255.f, 0.f/255.f, 1.f);// 空心圆边颜色
            CGContextSetRGBFillColor(context, 255.f/255.f, 0.f/255.f, 0.f/255.f, 1.f);// 中心圆颜色
        }
        
        defalutLineWidth = __SELECTEDLINEWIDTH;
        
        // 中心圆
        CGRect frame = CGRectMake(CGRectGetWidth(self.frame)*3/8,
                                  CGRectGetHeight(self.frame)*3/8,
                                  CGRectGetWidth(self.frame)/4,
                                  CGRectGetHeight(self.frame)/4);
        CGContextAddEllipseInRect(context, frame);
        CGContextFillPath(context);
    } else {
        CGContextSetRGBStrokeColor(context, 69.f/255.f, 174.f/255.f, 246.f/255.f, 1.f); // 空心圆边颜色
    }
    
    // 默认空心圆
    CGContextAddEllipseInRect(context, frame);
    CGContextSetLineWidth(context, defalutLineWidth); // 空心圆边长宽度
    CGContextStrokePath(context);
}

@end
