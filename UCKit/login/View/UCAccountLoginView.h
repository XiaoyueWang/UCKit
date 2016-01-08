//
//  UCAccountLoginView.h
//  UCCategories
//
//  Created by Uncle.Chen on 1/5/16.
//  Copyright © 2016 Uncle.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UCAccountLoginViewDelegate <NSObject>

/// 登录按钮代理方法
- (void)loginButtonAction;

@end

typedef void(^AddLogoImageViewConstraints)();
typedef void(^AddAccoutTextFieldConstraints)();
typedef void(^AddPasswordTextFieldConstraints)();
typedef void(^AddLoginButtonConstraints)();

@interface UCAccountLoginView : UIView

@property (nonatomic, strong) UIImageView *logoImageView; ///< Logo图片
@property (nonatomic, strong) UITextField *accoutTextField; ///< 帐号输入框
@property (nonatomic, strong) UITextField *passwordTextField; ///< 帐号输入框
@property (nonatomic, strong) UIButton *loginButton; ///< 登录按钮
@property (nonatomic, strong) id <UCAccountLoginViewDelegate> delegate; ///< 登录delegate，返回登录结果
@property (nonatomic, strong) AddLogoImageViewConstraints addLogoImageViewConstraints; ///< LogoImageView Constraints. The only way to set its frame. If there is no set, use the de default frame.
@property (nonatomic, strong) AddAccoutTextFieldConstraints addAccoutTextFieldConstraints; ///< AccoutTextField Constraints. The only way to set its frame. If there is no set, use the de default frame.
@property (nonatomic, strong) AddPasswordTextFieldConstraints addPasswordTextFieldConstraints; ///< PasswordTextField Constraints. The only way to set its frame. If there is no set, use the de default frame.
@property (nonatomic, strong) AddLoginButtonConstraints addLoginButtonConstraints; ///< LoginButton Constraints. The only way to set its frame. If there is no set, use the de default frame.


@end
