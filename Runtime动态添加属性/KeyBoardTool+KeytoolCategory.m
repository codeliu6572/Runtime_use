//
//  KeyBoardTool+KeytoolCategory.m
//  Runtime动态添加属性
//
//  Created by 刘浩浩 on 16/8/8.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "KeyBoardTool+KeytoolCategory.h"
#import <objc/runtime.h> //runtime API的使用需要包含此头文件

//增加多个属性，key值不能一样
const char * keytool = "keytool"; //做为key，字符常量 必须是C语言字符串；
const char * keytool2 = "keytool2"; //做为key，字符常量 必须是C语言字符串；
@implementation KeyBoardTool (KeytoolCategory)

/**
 *  添加新属性
 *
 *  @param newVariable 新属性名
 */
-(void)setNewVariable:(NSString *)newVariable{
    
    NSString *newStr = [NSString stringWithFormat:@"%@",newVariable];
    /*
     第一个参数是需要添加属性的对象；
     第二个参数是属性的key;
     第三个参数是属性的值;
     第四个参数是一个枚举值，类似@property属性创建时设置的关键字，可从命名看出各含义
     */
    objc_setAssociatedObject([KeyBoardTool class],keytool, newStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 *  提取属性的值
 *
 *  @return 属性值
 */
-(NSString *)newVariable{
    NSString *myNewVariable = objc_getAssociatedObject([KeyBoardTool class], keytool);
    return myNewVariable;
}

/**
 *  添加新属性
 *
 *  @param newVariable 新属性名
 */
-(void)setHeight:(float)height{
    NSNumber *num = [NSNumber numberWithFloat:height];
    /*
     第一个参数是需要添加属性的对象;
     第二个参数是属性的key;
     第三个参数是属性的值;
     第四个参数是一个枚举值，类似@property属性创建时设置的关键字，可从命名看出各含义
     */
    objc_setAssociatedObject([KeyBoardTool class],keytool2, num, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 *  提取属性的值
 *
 *  @return 属性值
 */
-(float)height{
    NSNumber *number = objc_getAssociatedObject([KeyBoardTool class], keytool2);
    return [number floatValue];
}

@end
