//
//  BaseViewController.h
//  ZY-Houserkeeper
//
//  Created by jk on 17/6/27.
//  Copyright © 2017年 jk. All rights reserved.
//
#import <UIKit/UIKit.h>

//左边按钮点击回调
typedef void(^LeftNavBtnClickBlock)();
//右边按钮点击回调
typedef void(^RightNavBtnClickBlock)();
//UIAlert点击监听
typedef void(^AlertItemClickBlock)(NSInteger index);
//带输入框UIAlert点击监听
typedef void(^AlertInputItemClickBlock)(NSInteger index, NSString *inputText);


@interface JKBaseNavigationBarViewController : UIViewController

/**
 设置导航栏文字颜色
 */
@property (strong, nonatomic) UIColor *navTintColor;

/**
 设置导航栏图片背景
 */
@property (strong, nonatomic) UIImage *navBgImage;

/**
 设置导航栏背景颜色
 */
@property (strong, nonatomic) UIColor *navBgColor;

/**
 设置是否显示导航栏底部线条
 */
@property (assign, nonatomic) BOOL hideNavShadow;

/**
 设置是否显示导航栏
 */
@property (assign, nonatomic) BOOL hideNavigationBar;

/**
 设置是否隐藏返回键
 */
@property (assign, nonatomic) BOOL hideBackButton;

/**
 重置左按键标题
 */
@property (strong, nonatomic) NSString *navLeftTitle;

/**
 使能左按键
 */
@property (assign, nonatomic) BOOL enableNavLeftBtn;

/**
 设置左按键文字颜色
 */
@property (strong, nonatomic) UIColor *navLeftBtnColor;

/**
 重置右按键标题
 */
@property (strong, nonatomic) NSString *navRightTitle;

/**
 使能右按键
 */
@property (assign, nonatomic) BOOL enableNavRightBtn;

/**
 设置右按键文字颜色
 */
@property (strong, nonatomic) UIColor *navRightBtnColor;

/**
 设置自定义title颜色
 */
@property (strong, nonatomic) NSString *navCustomTitleColor;

/**
 自定义文本标题
 */
@property (strong, nonatomic) NSString *navCustomTitle;


/**
 自我销毁
 */
- (void)destroySelfFromNav;

/**
 添加自定义左按键
 
 @param title      按键标题
 @param icon       按键icon
 @param clickBlock 点击监听
 */
- (void)addNavLeftBtnWithTitle:(NSString *)title icon:(NSString *)icon clickBlock:(LeftNavBtnClickBlock)clickBlock;

/**
 自定义左边按钮
 
 @param view      自定义按钮view
 */
- (void)addNavLeftView:(UIView *)view leftSpace:(CGFloat)leftSpace;

/**
 添加自定义右按键
 
 @param title      按键标题
 @param icon       按键icon
 @param clickBlock 点击监听
 */
- (void)addNavRightBtnWithTitle:(NSString *)title icon:(NSString *)icon clickBlock:(RightNavBtnClickBlock)clickBlock ;

/**
 自定义右边按键
 
 @param view      自定义view
 */
- (void)addNavRightView:(UIView *)view rightSpace:(CGFloat)rightSpace;

/**
 添加自定义标题view
 
 @param view 自定义view
 */
- (void)addNavCustomTitleView:(UIView *)view;

/**
 添加返回键点击监听
 
 @param clickBlock 监听block
 */
- (void)addNavBackBtnClickBlock:(LeftNavBtnClickBlock)clickBlock isPop:(BOOL)isPop;

/**
 显示AlertView
 
 @param title        标题
 @param message      信息
 @param buttonTitles 按键组标题
 @param clickBlock   点击事件
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles itemClickBlock:(AlertItemClickBlock)clickBlock;

/**
 显示单确认键提示
 
 @param title        标题
 @param message      信息
 @param clickBlock   点击事件
 */
- (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmBlock:(AlertItemClickBlock)clickBlock;

/**
 显示输入框提示
 
 @param title        标题
 @param message      信息
 @param placeholder  输入框placeholder
 @param keyboardType 弹出键盘属性
 @param clickBlock   点击事件
 */
- (void)showInputAlertWithTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType confirmBlock:(AlertInputItemClickBlock)clickBlock;

/**
 显示ActionSheetView
 
 @param title        标题
 @param buttonTitles 按键组标题
 @param clickBlock   点击事件
 */
- (void)showActionSheetWithTitle:(NSString *)title buttonTitles:(NSArray *)buttonTitles itemClickBlock:(AlertItemClickBlock)clickBlock;

@end
