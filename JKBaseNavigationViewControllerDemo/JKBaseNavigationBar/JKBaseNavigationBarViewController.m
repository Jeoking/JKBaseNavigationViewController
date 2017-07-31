//
//  BaseViewController.m
//  ZY-Houserkeeper
//
//  Created by jk on 17/6/27.
//  Copyright © 2017年 jk. All rights reserved.
//

#import "JKBaseNavigationBarViewController.h"

//>>>>>>>>>>>>>>>>>>>>>>>>>自定义UINavigationBar 王嘉 2017-04-06

//默认返回键标题
static NSString *BackBtnIcon = @"nav_back";
//默认返回键标题
static NSString *BackDefaultTitle = @"返回";

//左按键左边距
static const CGFloat LeftViewSpace = 8;
//右按键右边距
static const CGFloat RightViewSpace = 8;
//左按键图标边距
static const CGFloat LeftBtnIconSpace = 8;
//右按键图标边距
static const CGFloat RightBtnIconSpace = 8;
//左边按键文字大小设置
static const CGFloat NavLeftButtonTextSize = 16;
//右边按键文字大小设置
static const CGFloat NavRightButtonTextSize = 16;
//导航栏标题文字大小设置
static const CGFloat NavTitleTextSize = 18;
//返回键标题距图标边距
static const CGFloat BackBtnTitleToIconSpace = 4;
//返回键标题最大显示字数
static const NSInteger BackBtnTitleMaxLength = 5;
//返回键是否显示上一级标题
static const BOOL isShowPreTitle = NO;

///<<<<<<<<<<<<<<<<<<<<<<<<自定义UINavigationBar 王嘉 2017-04-06

@interface JKBaseNavigationBarViewController()
//>>>>>>>>>>>>>>>>>>>>>>>>>>自定义UINavigationBar 王嘉 2017-04-06
/**
 左按键点击block
 */
@property (strong, nonatomic) LeftNavBtnClickBlock leftNavBtnClickBlock;

/**
 右按键点击block
 */
@property (strong, nonatomic) RightNavBtnClickBlock rightNavBtnClickBlock;

/**
 返回键
 */
@property (strong, nonatomic) UIButton *navBackBtn;
/**
 左按键
 */
@property (strong, nonatomic) UIButton *navLeftBtn;
/**
 右按键
 */
@property (strong, nonatomic) UIButton *navRightBtn;
/**
 标题
 */
@property (strong, nonatomic) UILabel *navTitleLabel;

/**
 拦截返回事件后是否触发返回
 */
@property (assign, nonatomic) BOOL isPop;

@end

@implementation JKBaseNavigationBarViewController

#pragma mark - 自我销毁
- (void)destroySelfFromNav {
    //将自己从堆栈中移除
    if (self.navigationController && self.navigationController.viewControllers.count > 0) {
        NSMutableArray * array =[[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        [array removeObjectAtIndex:array.count-2];
        [self.navigationController setViewControllers:array animated:NO];
    }
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isPop = YES;
    
    //>>>>>>>>>>>>>>>>>>>>>>>>>>自定义UINavigationBar 王嘉 2017-04-06
    //默认添加自定义返回键
    if (!isShowPreTitle) {
        //返回键若设置不显示上层标题，则设置默认
        [self addNavBackBtn:BackDefaultTitle];
        return;
    }
    //设置显示上层viewController标题
    NSInteger vcCount = self.navigationController.viewControllers.count;
    if (vcCount > 1 && [self.navigationController.viewControllers[vcCount - 2] isKindOfClass:[JKBaseNavigationBarViewController class]]) {
        JKBaseNavigationBarViewController *preVC = self.navigationController.viewControllers[vcCount - 2];
        NSString *backBtnTitle = @"返回";
        if (preVC.navCustomTitle.length > 0) {
            backBtnTitle = preVC.navCustomTitle;
        }
        [self addNavBackBtn:backBtnTitle];
    }
    
}
#pragma mark -

#pragma mark - 设置navigationBar

/**
 设置导航栏文字颜色
 
 @param color 颜色
 */
- (void)setNavTintColor:(UIColor *)color {
    if (color) {
        self.navigationController.navigationBar.tintColor = color;
    }
}

/**
 设置导航栏图片背景
 
 @param image 背景图片
 */
- (void)setNavBgImage:(UIImage *)image {
    if (image) {
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
}

/**
 设置导航栏背景颜色
 
 @param color 背景图片
 */
- (void)setNavBgColor:(UIColor *)color {
    if (color) {
        [self.navigationController.navigationBar setBackgroundColor:color];
    }
}

/**
 设置是否显示导航栏底部线条
 
 @param isHide 是否显示
 */
- (void)setHideNavShadow:(BOOL)isHide {
    if (isHide) {
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    } else {
        [self.navigationController.navigationBar setShadowImage:nil];
    }
}

/**
 设置是否显示导航栏
 
 @param isHide 是否显示
 */
- (void)setHideNavigationBar:(BOOL)isHide {
    self.navigationController.navigationBar.hidden = isHide;
}

/**
 设置是否隐藏返回键
 
 @param isHide 是否显示
 */
- (void)setHideBackButton:(BOOL)isHide {
    self.navBackBtn.hidden = isHide;
}

/**
 重置左按键标题
 
 @param leftTitle 标题
 */
- (void)setNavLeftTitle:(NSString *)leftTitle {
    if (_navLeftBtn && leftTitle) {
        [_navLeftBtn setTitle:leftTitle forState:UIControlStateNormal];
    }
}

/**
 使能左按键
 
 @param isEnable 是否使能
 */
- (void)setEnableNavLeftBtn:(BOOL)isEnable {
    if (_navLeftBtn) {
        _navLeftBtn.enabled = isEnable;
    }
}

/**
 设置左按键文字颜色
 
 @param color 颜色
 */
- (void)setNavLeftBtnColor:(UIColor *)color {
    if (_navLeftBtn && color) {
        [_navLeftBtn setTitleColor:color forState:UIControlStateNormal];
    }
}

/**
 添加自定义左按键
 
 @param title      按键标题
 @param icon       按键icon
 @param clickBlock 点击监听
 */
- (void)addNavLeftBtnWithTitle:(NSString *)title icon:(NSString *)icon clickBlock:(LeftNavBtnClickBlock)clickBlock {
    //判断是否含图标
    if (icon) {
        [self.navLeftBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [self.navLeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, LeftBtnIconSpace, 0, 0)];
        self.navLeftBtn.frame = CGRectMake(0, 0, 44, 44);
    }
    //判断是否含标题
    if (title) {
        [self.navLeftBtn setTitle:title forState:UIControlStateNormal];
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:NavLeftButtonTextSize]};
        CGSize size = [title sizeWithAttributes:attrs];
        CGFloat width = size.width + 8;
        if (icon) {
            width = size.width + LeftBtnIconSpace + 22;
        }
        self.navLeftBtn.frame = CGRectMake(0, 0, width, 44);
    }
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = LeftViewSpace - 16;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarItem];
    [self.navLeftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftNavBtnClickBlock = clickBlock;
}

/**
 自定义左边控件
 
 @param view      自定义按钮view
 */
- (void)addNavLeftView:(UIView *)view leftSpace:(CGFloat)leftSpace {
    if (view) {
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        //设置边距 ios7.0+
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = leftSpace - 16;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarItem];
    }
}

/**
 重置右按键标题
 
 @param rightTitle 标题
 */
- (void)setNavRightTitle:(NSString *)rightTitle {
    if (_navRightBtn && rightTitle) {
        [_navRightBtn setTitle:rightTitle forState:UIControlStateNormal];
    }
}

/**
 使能右按键
 
 @param isEnable 是否使能
 */
- (void)setEnableNavRightBtn:(BOOL)isEnable {
    if (_navRightBtn) {
        _navRightBtn.enabled = isEnable;
    }
}

/**
 设置右按键文字颜色
 
 @param color 颜色
 */
- (void)setNavRightBtnColor:(UIColor *)color {
    if (_navRightBtn && color) {
        [_navRightBtn setTitleColor:color forState:UIControlStateNormal];
    }
}

/**
 添加自定义右按键
 
 @param title      按键标题
 @param icon       按键icon
 @param clickBlock 点击监听
 */
- (void)addNavRightBtnWithTitle:(NSString *)title icon:(NSString *)icon clickBlock:(RightNavBtnClickBlock)clickBlock {
    if (icon) {
        [self.navRightBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [self.navRightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, RightBtnIconSpace)];
        self.navRightBtn.frame = CGRectMake(0, 0, 44, 44);
    }
    if (title) {
        [self.navRightBtn setTitle:title forState:UIControlStateNormal];
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:NavRightButtonTextSize]};
        CGSize size = [title sizeWithAttributes:attrs];
        CGFloat width = size.width + 8;
        if (icon) {
            width = size.width + RightBtnIconSpace + 22;
        }
        self.navRightBtn.frame = CGRectMake(0, 0, width, 44);
    }
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = RightViewSpace - 16;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightBarItem];
    [self.navRightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightNavBtnClickBlock = clickBlock;
}

/**
 自定义右边控件
 
 @param view      自定义view
 */
- (void)addNavRightView:(UIView *)view rightSpace:(CGFloat)rightSpace {
    if (view) {
        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        //设置边距 ios7.0+
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = rightSpace - 16;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightBarItem];
    }
}

/**
 添加自定义文本标题
 
 @param title 标题
 */
- (void)setNavCustomTitle:(NSString *)title {
    if (title){
        _navCustomTitle = title;
        self.navTitleLabel.text = title;
        self.navigationItem.titleView = self.navTitleLabel;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:NavTitleTextSize]};
        CGSize size = [title sizeWithAttributes:attrs];
        self.navTitleLabel.frame = CGRectMake(0, 0, size.width, 44);
    }
}

/**
 设置自定义title颜色
 
 @param color 颜色
 */
- (void)setNavCustomTitleColor:(UIColor *)color {
    if (_navTitleLabel && color) {
        _navTitleLabel.textColor = color;
    }
}

/**
 添加自定义标题view
 
 @param view 自定义view
 */
- (void)addNavCustomTitleView:(UIView *)view {
    if (view){
        self.navigationItem.titleView = view;
    }
}

/**
 添加返回键点击监听
 
 @param clickBlock 监听block
 */
- (void)addNavBackBtnClickBlock:(LeftNavBtnClickBlock)clickBlock isPop:(BOOL)isPop {
    self.leftNavBtnClickBlock = clickBlock;
    self.isPop = isPop;
}

/**
 添加返回键
 
 @param title 返回键标题
 */
- (void)addNavBackBtn:(NSString *)title {
    NSInteger num = self.navigationController.viewControllers.count;
    if (num == 1) {
        self.navBackBtn.hidden = YES;
    } else {
        self.navBackBtn.hidden = NO;
        //计算按钮title长度
        if (title.length > BackBtnTitleMaxLength) {
            title = BackDefaultTitle;
        }
        [self.navBackBtn setTitle:title forState:UIControlStateNormal];
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:NavLeftButtonTextSize]};
        CGSize size = [title sizeWithAttributes:attrs];
        self.navBackBtn.frame = CGRectMake(0, 0, size.width + BackBtnTitleToIconSpace + 16, 44);
    }
}

#pragma mark -

#pragma mark - getting

/**
 自定义标题
 
 @return 自定义标题UILabel
 */
- (UILabel *)navTitleLabel {
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] init];
        _navTitleLabel.font = [UIFont boldSystemFontOfSize:NavTitleTextSize];
    }
    return _navTitleLabel;
}

/**
 自定义左边按钮
 
 @return 自定义左边按钮UIButton
 */
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        _navLeftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _navLeftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.navLeftBtn.titleLabel.font = [UIFont systemFontOfSize:NavLeftButtonTextSize];
    }
    return _navLeftBtn;
}

/**
 自定义右边按钮
 
 @return 自定义右边按钮UIButton
 */
- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        _navRightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _navRightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.navRightBtn.titleLabel.font = [UIFont systemFontOfSize:NavRightButtonTextSize];
    }
    return _navRightBtn;
}

/**
 自定义返回键
 
 @return 自定义返回键UIButton
 */
- (UIButton *)navBackBtn {
    if (!_navBackBtn) {
        _navBackBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _navBackBtn.titleLabel.font = [UIFont systemFontOfSize:NavLeftButtonTextSize];
        _navBackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_navBackBtn setImage:[UIImage imageNamed:BackBtnIcon] forState:UIControlStateNormal];
        [_navBackBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, BackBtnTitleToIconSpace, 0, 0)];
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:_navBackBtn];
        //设置边距 ios7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = LeftViewSpace - 16;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarItem];
        
        [_navBackBtn addTarget:self action:@selector(backMaskButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBackBtn;
}

#pragma mark - nav btn action

/**
 左按钮点击监听
 */
- (void)leftBtnAction {
    if (self.leftNavBtnClickBlock) {
        self.leftNavBtnClickBlock();
    }
}

/**
 右按钮点击监听
 */
- (void)rightBtnAction {
    if (self.rightNavBtnClickBlock) {
        self.rightNavBtnClickBlock();
    }
}

/**
 返回按键点击监听
 */
- (void)backMaskButtonTouched:(UIButton *)button {
    //若leftNavBtnClickBlock不为空，则拦截返回按键
    if (self.leftNavBtnClickBlock) {
        self.leftNavBtnClickBlock();
    }
    if (!self.isPop) {
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 显示AlertView
 
 @param title        标题
 @param message      信息
 @param buttonTitles 按键组标题
 @param clickBlock   点击事件
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles itemClickBlock:(AlertItemClickBlock)clickBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (clickBlock) {
            clickBlock(-1);
        }
    }];
    [alertController addAction:cancelAction];
    
    for (int i = 0; i < buttonTitles.count; i++) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:buttonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (clickBlock) {
                clickBlock(i);
            }
        }];
        [alertController addAction:otherAction];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 显示单确认键提示
 
 @param title        标题
 @param message      信息
 @param clickBlock   点击事件
 */
- (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmBlock:(AlertItemClickBlock)clickBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    // Create the actions.
    NSString *btnTitle = @"确定";
    if (confirmTitle) {
        btnTitle = confirmTitle;
    }
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (clickBlock) {
            clickBlock(0);
        }
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 显示输入框提示
 
 @param title        标题
 @param message      信息
 @param placeholder  输入框placeholder
 @param keyboardType 弹出键盘属性
 @param clickBlock   点击事件
 */
- (void)showInputAlertWithTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType confirmBlock:(AlertInputItemClickBlock)clickBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Add the text field for the secure text entry.
    __block UITextField *inputTextField = nil;
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = placeholder;
        textField.keyboardType = keyboardType;
        inputTextField = textField;
    }];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (clickBlock) {
            clickBlock(-1, inputTextField.text);
        }
    }];
    [alertController addAction:cancelAction];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (clickBlock) {
            clickBlock(0, inputTextField.text);
        }
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 显示ActionSheetView
 
 @param title        标题
 @param buttonTitles 按键组标题
 @param clickBlock   点击事件
 */
- (void)showActionSheetWithTitle:(NSString *)title buttonTitles:(NSArray *)buttonTitles itemClickBlock:(AlertItemClickBlock)clickBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (clickBlock) {
            clickBlock(-1);
        }
    }];
    [alertController addAction:cancelAction];
    
    for (int i = 0; i < buttonTitles.count; i++) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:buttonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (clickBlock) {
                clickBlock(i);
            }
        }];
        [alertController addAction:otherAction];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
