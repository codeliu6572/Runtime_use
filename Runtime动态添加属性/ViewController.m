//
//  ViewController.m
//  Runtime动态添加属性
//
//  Created by 刘浩浩 on 16/8/5.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"

#import "KeyBoardTool.h"

#import "KeyBoardTool+KeytoolCategory.h"

#import "ViewController+VVC.h"
@interface ViewController ()


@end

@implementation ViewController
-(NSString *)description{
    return [NSString stringWithFormat:@"hello:%@",_hello];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _hello = @"hello";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _hello = @"hello";
    UITextField *mtTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, 300, 40)];
    mtTextField.borderStyle = UITextBorderStyleRoundedRect;
    mtTextField.placeholder = @"Hello";
    mtTextField.clearButtonMode = UITextFieldViewModeAlways;
    //给textfield增加隐藏键盘按钮
    [KeyBoardTool hideKeyboard:mtTextField];
    [self.view addSubview:mtTextField];
    //获取某一个类所有属性和所有方法
    [KeyBoardTool getAllPropertyAndAllMethod:[UITextField class]];
    //改变某一属性值
    [KeyBoardTool changeVariable];
    //增加新方法
    [KeyBoardTool addNewMethod];
    //交换方法
    [KeyBoardTool exchangeMethod];
    
    
    //增加新属性
    KeyBoardTool *keytool = [[KeyBoardTool alloc]init];
    keytool.newVariable = @"Hello";
    keytool.height = 100;
    NSLog(@"%@",[keytool newVariable]);
    NSLog(@"%f",[keytool height]);
    

    self.vccVariable = @"world";
    NSLog(@"%@",[self vccVariable]);
}

- (void)method1
{
    NSLog(@"method1");
}
- (void)method2
{
    NSLog(@"method2");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
