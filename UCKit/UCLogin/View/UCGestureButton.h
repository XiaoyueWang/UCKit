//
//  UCGestureButton.h
//  UCCategories
//
//  Created by Uncle.Chen on 1/5/16.
//  Copyright © 2016 Uncle.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCGestureButton : UIView

@property (nonatomic, assign) BOOL selected;///< 选中标识
@property (nonatomic, assign) BOOL success;///< button验证是否正确 Default is YES
@property (nonatomic, assign) BOOL isHollowOut;///< 是否镂空 Default is YES

@end
