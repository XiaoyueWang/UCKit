//
//  UCGestureLoginView.m
//  UCCategories
//
//  Created by Uncle.Chen on 1/5/16.
//  Copyright © 2016 Uncle.Chen. All rights reserved.
//

#import "UCGestureLoginView.h"
#import "UCGestureButton.h"

#define __DEFAULTCOLOR [UIColor colorWithRed:69.f/255.f green:174.f/255.f blue:246.f/255.f alpha:1.f]

static CGFloat const __DEFAULTTOPSPACE = 100.f;

@interface UCGestureLoginView ()

@property (nonatomic, strong) NSMutableArray *touchesArray; ///< button数组，存放已点亮button信息，point、value
@property (nonatomic, strong) NSMutableArray *touchedArray; ///< 已点亮button数组，避免重复点亮、连线路径重复
@property (nonatomic, assign) BOOL success; ///< 手势密码验证是否成功
@property (nonatomic, assign) CGPoint lineEndPoint; ///< 手势终点point

@end

@implementation UCGestureLoginView

#pragma mark - Life Cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initVariable];
        [self loadMessageLabel];
        [self loadGestureButtons];
    }
    return self;
}

- (void)initVariable {
    self.gestureButtonArray = [[NSMutableArray alloc] init];
    self.touchesArray = [[NSMutableArray alloc] init];
    self.touchedArray = [[NSMutableArray alloc] init];
    self.success = YES;
}

- (void)layoutSubviews {
    [self loadMessageLabelFrame];
    [self loadGestureButtonsFrame];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (int i = 0; i < self.touchesArray.count; i++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (![[self.touchesArray objectAtIndex:i] objectForKey:@"num"]) { //防止过快滑动产生垃圾数据
            [self.touchesArray removeObjectAtIndex:i];
            continue;
        }
        
        // 路径线条颜色
        if (self.success) {
            CGContextSetRGBStrokeColor(context, 2.f/255.f, 174.f/255.f, 240.f/255.f, 1.f);
        } else {
            CGContextSetRGBStrokeColor(context, 255.f/255.f, 0.f/255.f, 0.f/255.f, 1.f);
        }
        
        CGContextSetLineWidth(context, 1.f); // 路径线条宽度
        CGContextMoveToPoint(context, [[[self.touchesArray objectAtIndex:i] objectForKey:@"x"] floatValue], [[[self.touchesArray objectAtIndex:i] objectForKey:@"y"] floatValue]);
        
        if (i < self.touchesArray.count-1) {
            CGContextAddLineToPoint(context, [[[self.touchesArray objectAtIndex:i+1] objectForKey:@"x"] floatValue], [[[self.touchesArray objectAtIndex:i+1] objectForKey:@"y"] floatValue]);
        } else {
            if (self.success) {
                CGContextAddLineToPoint(context, self.lineEndPoint.x, self.lineEndPoint.y);
            }
        }
        CGContextStrokePath(context);
    }
}

#pragma mark - UI

- (void)loadMessageLabel {
    self.messageLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = __DEFAULTCOLOR;
        label.text = @"请输入手势密码";
        label.font = [UIFont systemFontOfSize:14.f];
        label;
    });
    [self addSubview:self.messageLabel];
}

- (void)loadGestureButtons {
    for (int i = 1; i <= 9; i++) {
        UCGestureButton *gestureButton = ({
            UCGestureButton *button = [[UCGestureButton alloc] init];
            button.tag = i;
            button;
        });
        [self addSubview:gestureButton];
        [self.gestureButtonArray addObject:gestureButton];
    }
}

- (void)loadMessageLabelFrame {
    if (self.setMessageLabelFrame) {
        self.setMessageLabelFrame();
    } else {
        self.messageLabel.frame = CGRectMake(0.f, __DEFAULTTOPSPACE,
                                             CGRectGetWidth(self.frame), 30.f);
    }
}

- (void)loadGestureButtonsFrame {
    if (self.setGestureButtonsFrame) {
        self.setGestureButtonsFrame();
    } else {
        CGFloat widthUnit = CGRectGetWidth(self.frame)/10;
        for (UCGestureButton *button in self.gestureButtonArray) {
            NSInteger index = button.tag;
            button.frame  = ({
                CGRectMake(widthUnit+widthUnit*3*((index-1)%3),
                           CGRectGetMaxY(self.messageLabel.frame)+widthUnit*3*((index-1)/3),
                           widthUnit*2,
                           widthUnit*2);
            });
        }
    }
}

#pragma mark - Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.touchesArray.count != 0) {
        [self.touchesArray removeAllObjects];
    }
    
    if (self.touchedArray.count != 0) {
        [self.touchedArray removeAllObjects];
    }
    
    self.messageLabel.text = @"";
    self.success = YES;
    
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
    
    if (touch) {
        touchPoint = [touch locationInView:self];
        for (int i = 0; i < self.gestureButtonArray.count; i++) {
            UCGestureButton *button = (UCGestureButton *)[self.gestureButtonArray objectAtIndex:i];
            button.success = YES;
            button.selected = NO;
            
            if (CGRectContainsPoint(button.frame, touchPoint)) {
                NSDictionary * dict = ({
                    @{@"x":[NSString stringWithFormat:@"%f", CGRectGetMidX(button.frame)],
                      @"y":[NSString stringWithFormat:@"%f", CGRectGetMidY(button.frame)]};
                });
                [self.touchesArray addObject:dict];
            }
            [button setNeedsDisplay];
        }
        [self setNeedsDisplay];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
    if (touch) {
        touchPoint = [touch locationInView:self];
        for (int i = 0; i < self.gestureButtonArray.count; i++) {
            UCGestureButton *button = (UCGestureButton *)[self.gestureButtonArray objectAtIndex:i];
            if (CGRectContainsPoint(button.frame, touchPoint)) {
                //若此button已经点亮，则略过
                if ([self.touchedArray containsObject:[NSString stringWithFormat:@"num%d", i]]) {
                    self.lineEndPoint = touchPoint;
                    [self setNeedsDisplay];
                    return;
                }
                
                [self.touchedArray addObject:[NSString stringWithFormat:@"num%d", i]];
                button.selected = YES;
                [button setNeedsDisplay];
                
                NSDictionary * dict = ({
                    @{@"x":[NSString stringWithFormat:@"%f", CGRectGetMidX(button.frame)],
                      @"y":[NSString stringWithFormat:@"%f", CGRectGetMidY(button.frame)],
                      @"num":[NSString stringWithFormat:@"%d", i]};
                });
                [self.touchesArray addObject:dict];
                
                break;
            }
        }
        self.lineEndPoint = touchPoint;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSMutableString * resultString = [NSMutableString string];
    for (NSDictionary *num in self.touchesArray){
        if (![num objectForKey:@"num"]) {
            break;
        }
        [resultString appendString:[num objectForKey:@"num"]];
    }
    
    if (self.success) {
        self.messageLabel.textColor = __DEFAULTCOLOR;
    } else {
        self.messageLabel.textColor = [UIColor redColor];
    }
    
    [self.delegate gesturePassword:resultString];
    
    for (int i = 0; i < self.touchesArray.count; i++) {
        NSInteger selection = [[[self.touchesArray objectAtIndex:i] objectForKey:@"num"] intValue];
        UCGestureButton *button = (UCGestureButton *)[self.gestureButtonArray objectAtIndex:selection];
        button.success = self.success;
        [button setNeedsDisplay];
    }
    [self setNeedsDisplay];
}

#pragma mark - Helper

- (void)refresh {
    [self.touchesArray removeAllObjects];
    [self.touchedArray removeAllObjects];
    
    for (UCGestureButton *button in self.gestureButtonArray) {
        button.selected = NO;
        button.success = YES;
        [button setNeedsDisplay];
    }
    
    [self setNeedsDisplay];
}

@end
