//
//  ViewController+VVC.m
//  Runtime动态添加属性
//
//  Created by 刘浩浩 on 16/8/8.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController+VVC.h"
#import <objc/runtime.h> //runtime API的使用需要包含此头文件

const char * vcc = "vcckey"; //做为key，字符常量 必须是C语言字符串；
@implementation ViewController (VVC)


-(void)setVccVariable:(NSString *)vccVariable{
    
    NSString *newStr = [NSString stringWithFormat:@"%@",vccVariable];
    /*
     第一个参数是需要添加属性的对象;
     第二个参数是属性的key;
     第三个参数是属性的值;
     第四个参数是一个枚举值，类似@property属性创建时设置的关键字，可从命名看出各含义
     */
    objc_setAssociatedObject([ViewController class],vcc, newStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//提取属性的值:
-(NSString *)vccVariable{
    NSString *myVccVariable = objc_getAssociatedObject([ViewController class], vcc);
    return myVccVariable;
}


@end
