//
//  UCGestureLoginView.h
//  UCCategories
//
//  Created by Uncle.Chen on 1/5/16.
//  Copyright © 2016 Uncle.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UCGestureDelegate <NSObject>

- (BOOL)gesturePassword:(NSString *)gesturePassword;

@optional
- (void)gestureTouchBegin;

@end

typedef void(^SetMessageLabelFrame)();
typedef void(^SetGestureButtonsFrame)();

@interface UCGestureLoginView : UIView

@property (nonatomic, strong) NSMutableArray *gestureButtonArray; ///< button对象数组
@property (nonatomic, strong) UILabel *messageLabel; ///< Message label
@property (nonatomic, strong) id <UCGestureDelegate> delegate;
@property (nonatomic, assign) SetMessageLabelFrame setMessageLabelFrame; ///< The only way to set its frame. If there is no set, use the de default frame.
@property (nonatomic, assign) SetGestureButtonsFrame setGestureButtonsFrame; ///< Iterate through the gestureButtonArray to set gestureButtons' frame. The only way to set its frame. If there is no set, use the de default frame.

/// 刷新
- (void)refresh;

@end
