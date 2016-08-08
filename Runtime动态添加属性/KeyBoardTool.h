//
//  KeyBoardTool.h
//  Runtime动态添加属性
//
//  Created by 刘浩浩 on 16/8/5.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KeyBoardTool : NSObject


/**
 *  增加隐藏键盘按钮
 *
 *  @param textfield 输入框对象
 */
+ (void)hideKeyboard:(UITextField *)textfield;
/**
 *  获取所有成员变量和方法
 *
 *  @param myClass 类别
 */
+ (void)getAllPropertyAndAllMethod:(id)myClass;

/**
 *  改变属性值
 */
+ (void)changeVariable;
/**
 *  增加新方法
 */
+ (void)addNewMethod;
/**
 *  交换方法
 */
+ (void)exchangeMethod;

@end
