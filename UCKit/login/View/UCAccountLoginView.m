//
//  UCAccountLoginView.m
//  UCCategories
//
//  Created by Uncle.Chen on 1/5/16.
//  Copyright © 2016 Uncle.Chen. All rights reserved.
//

#import "UCAccountLoginView.h"
//#import "BNAccoutLoginViewModel.h"

@interface UCAccountLoginView ()

@end

@implementation UCAccountLoginView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadLogoImageView];
        [self loadAccoutTextField];
        [self loadPasswordTextField];
        [self loadLoginButton];    }
    return self;
}

- (void)layoutSubviews {
    [self loadLogoImageViewConstraints];
    [self loadAccoutTextFieldConstraints];
    [self loadPasswordTextFieldConstraints];
    [self loadLoginButtonConstraints];
}

#pragma mark - UI

- (void)loadLogoImageView {
    self.logoImageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 50.f;
        imageView;
    });
    [self addSubview:self.logoImageView];
}

- (void)loadAccoutTextField {
    self.accoutTextField = [self createTextField];
    self.accoutTextField.placeholder = @"帐号";
}

- (void)loadPasswordTextField {
    self.passwordTextField = [self createTextField];
    self.passwordTextField.placeholder = @"密码";
    self.passwordTextField.secureTextEntry = YES;
}

- (void)loadLoginButton {
    self.loginButton = ({
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor blackColor];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:self.loginButton];
}

- (void)loadLogoImageViewConstraints {
    if (self.addLogoImageViewConstraints) {
        self.addLogoImageViewConstraints();
    } else {
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *logoImageViewCenterXConstraint =
        [NSLayoutConstraint constraintWithItem:self.logoImageView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:64.f];
        
        NSLayoutConstraint *logoImageViewCenterYConstraint =
        [NSLayoutConstraint constraintWithItem:self.logoImageView
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1
                                      constant:0];
        
        NSLayoutConstraint *logoImageViewWidthConstraint =
        [NSLayoutConstraint constraintWithItem:self.logoImageView
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeWidth
                                    multiplier:1
                                      constant:100.f];
        
        NSLayoutConstraint *logoImageViewHeightConstraint =
        [NSLayoutConstraint constraintWithItem:self.logoImageView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1
                                      constant:100.f];
        
        [self addConstraints:@[logoImageViewCenterXConstraint,
                               logoImageViewCenterYConstraint,
                               logoImageViewWidthConstraint,
                               logoImageViewHeightConstraint]];
    }
}

- (void)loadAccoutTextFieldConstraints {
    if (self.addAccoutTextFieldConstraints) {
        self.addAccoutTextFieldConstraints();
    } else {
        self.accoutTextField.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *accoutTextFieldCenterXConstraint =
        [NSLayoutConstraint constraintWithItem:self.accoutTextField
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.logoImageView
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:20.f];
        
        NSLayoutConstraint *accoutTextFieldHeightConstraint =
        [NSLayoutConstraint constraintWithItem:self.accoutTextField
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1
                                      constant:32.f];
        
        NSLayoutConstraint *accoutTextFieldLeadingMarginConstraint =
        [NSLayoutConstraint constraintWithItem:self.accoutTextField
                                     attribute:NSLayoutAttributeLeadingMargin
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:20.f];
        
        NSLayoutConstraint *accoutTextFieldTrailingMarginConstraint =
        [NSLayoutConstraint constraintWithItem:self.accoutTextField
                                     attribute:NSLayoutAttributeTrailingMargin
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-20.f];
        
        [self addConstraints:@[accoutTextFieldCenterXConstraint,
                               accoutTextFieldHeightConstraint,
                               accoutTextFieldLeadingMarginConstraint,
                               accoutTextFieldTrailingMarginConstraint]];
    }
}

- (void)loadPasswordTextFieldConstraints {
    if (self.addPasswordTextFieldConstraints) {
        self.addPasswordTextFieldConstraints();
    } else {
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *passwordTextFieldCenterXConstraint =
        [NSLayoutConstraint constraintWithItem:self.passwordTextField
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.accoutTextField
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:10.f];
        
        NSLayoutConstraint *passwordTextFieldHeightConstraint =
        [NSLayoutConstraint constraintWithItem:self.passwordTextField
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1
                                      constant:32.f];
        
        NSLayoutConstraint *passwordTextFieldLeadingMarginConstraint =
        [NSLayoutConstraint constraintWithItem:self.passwordTextField
                                     attribute:NSLayoutAttributeLeadingMargin
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:20.f];
        
        NSLayoutConstraint *passwordTextFieldTrailingMarginConstraint =
        [NSLayoutConstraint constraintWithItem:self.passwordTextField
                                     attribute:NSLayoutAttributeTrailingMargin
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-20.f];
        
        [self addConstraints:@[passwordTextFieldCenterXConstraint,
                               passwordTextFieldHeightConstraint,
                               passwordTextFieldLeadingMarginConstraint,
                               passwordTextFieldTrailingMarginConstraint]];
    }
}

- (void)loadLoginButtonConstraints {
    if (self.addLoginButtonConstraints) {
        self.addLoginButtonConstraints();
    } else {
        self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *loginButtonCenterXConstraint =
        [NSLayoutConstraint constraintWithItem:self.loginButton
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.passwordTextField
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:10.f];
        
        NSLayoutConstraint *loginButtonHeightConstraint =
        [NSLayoutConstraint constraintWithItem:self.loginButton
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1
                                      constant:32.f];
        
        NSLayoutConstraint *loginButtonLeadingMarginConstraint =
        [NSLayoutConstraint constraintWithItem:self.loginButton
                                     attribute:NSLayoutAttributeLeadingMargin
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:50.f];
        
        NSLayoutConstraint *loginButtonTrailingMarginConstraint =
        [NSLayoutConstraint constraintWithItem:self.loginButton
                                     attribute:NSLayoutAttributeTrailingMargin
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-50.f];
        
        [self addConstraints:@[loginButtonCenterXConstraint,
                               loginButtonHeightConstraint,
                               loginButtonLeadingMarginConstraint,
                               loginButtonTrailingMarginConstraint]];
    }
}

- (UITextField *)createTextField {
    UITextField *textField = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.layer.borderWidth = 1.f;
        textField.layer.borderColor = [UIColor blackColor].CGColor;
        textField;
    });
    [self addSubview:textField];
    return textField;
}

#pragma mark - Action

- (void)loginButtonAction {
    [self.delegate loginButtonAction];
}

@end
