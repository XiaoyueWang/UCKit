//
//  UCLoginDemoViewController.m
//  UCKit
//
//  Created by Uncle.Chen on 1/5/16.
//  Copyright © 2016 Uncle.Chen. All rights reserved.
//

#import "UCLoginDemoViewController.h"
#import "UCKit.h"

@interface UCLoginDemoViewController () <UCAccountLoginViewDelegate,UCGestureDelegate>

@property (nonatomic, strong) UCAccountLoginView *accountLoginView;
@property (nonatomic, strong) UCGestureLoginView *gestureLoginView;
@property (nonatomic, strong) NSString *userName; ///< 登录ID
@property (nonatomic, strong) NSString *password; ///< 密码
@property (nonatomic, strong) NSString *gesturePassword; ///< 手势密码
@property (nonatomic, strong) NSString *firstGesturePassword; ///< 设置手势密码时，第一次输入的手势密码

@end

@implementation UCLoginDemoViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.userName != nil && ![self.userName isEqualToString:@""]) {
        [self loadGestureLoginView];
    } else {
        [self loadAccountLoginView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI

- (void)loadAccountLoginView {
    self.accountLoginView = ({
        UCAccountLoginView *view = [[UCAccountLoginView alloc] init];
        view.frame = self.view.frame;
        view.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        view.logoImageView.image = [UIImage imageNamed:@"logo"];
        view;
    });
    [self.view addSubview:self.accountLoginView];
}

- (void)loadGestureLoginView {
    self.gestureLoginView = ({
        UCGestureLoginView *view = [[UCGestureLoginView alloc] init];
        view.frame = self.view.frame;
        view.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        view;
    });
    [self.view addSubview:self.gestureLoginView];
}

#pragma mark - Datasource/Delegate

- (void)loginButtonAction {
    [self.accountLoginView removeFromSuperview];
    [self loadGestureLoginView];
}

- (BOOL)gesturePassword:(NSString *)gesturePassword {
    if (gesturePassword.length < 4) {
        self.gestureLoginView.messageLabel.text = @"密码节点不能少于4个";
        return NO;
    }
    
    // 登录，输入一次
    if (![self.gesturePassword isEqualToString:@""] &&
        self.gesturePassword != nil) {
        
        if ([gesturePassword isEqualToString:self.gesturePassword]) {
            self.gestureLoginView.messageLabel.text = @"";
            
            self.gestureLoginView.messageLabel.text = [NSString stringWithFormat:@"手势密码为：%@", gesturePassword];
            return YES;
        } else {
            self.gestureLoginView.messageLabel.text = @"手势密码错误";
            return NO;
        }
    }
    
    // 设置，输入两次
    if ([self.firstGesturePassword isEqualToString:@""] ||
        self.firstGesturePassword == nil) {
        
        [self.gestureLoginView refresh];
        self.gestureLoginView.messageLabel.text = @"请再次输入密码";
        self.firstGesturePassword = gesturePassword;
        return YES;
    } else {
        if ([self.firstGesturePassword isEqualToString:gesturePassword]) {
            self.gestureLoginView.messageLabel.text = [NSString stringWithFormat:@"手势密码为：%@", gesturePassword];
            self.firstGesturePassword = nil;
            return YES;
        } else {
            self.firstGesturePassword = nil;
            self.gestureLoginView.messageLabel.text = @"两次密码不一致，请重新输入";
            return NO;
        }
    }
    
    return NO;
}

@end
