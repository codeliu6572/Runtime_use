//
//  KeyBoardTool.m
//  Runtime动态添加属性
//
//  Created by 刘浩浩 on 16/8/5.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "KeyBoardTool.h"
#import <objc/runtime.h>
#import "ViewController.h"
//获取屏幕宽度的宏
#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)

static const void *kTextField = "mtTextField";

@implementation KeyBoardTool
{
    ViewController *viewVC;
}

+ (void)getAllPropertyAndAllMethod:(id)myClass
{
    unsigned int outCount = 0;
    // 获取到所有的成员变量列表
    Ivar *vars = class_copyIvarList([myClass class], &outCount);
    // 遍历所有的成员变量
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = vars[i]; // 取出第i个位置的成员变量
        
        const char *propertyName = ivar_getName(ivar); // 获取变量名
        const char *propertyType = ivar_getTypeEncoding(ivar); // 获取变量编码类型
        printf("%s/%s\n", propertyName, propertyType);
        
    }
    
    
    unsigned int count;
    //获取方法列表，所有在.m文件显式实现的方法都会被找到，包括setter+getter方法；
    Method *allMethods = class_copyMethodList([myClass class], &count);
    for(int i =0;i<count;i++)
    {
        //Method，为runtime声明的一个宏，表示对一个方法的描述
        Method md = allMethods[i];
        //获取SEL：SEL类型,即获取方法选择器@selector()
        SEL sel = method_getName(md);
        //得到sel的方法名：以字符串格式获取sel的name，也即@selector()中的方法名称
        const char *methodname = sel_getName(sel);
        NSLog(@"(Method:%s)",methodname);
    }
    
    
}

+ (void)changeVariable
{
    ViewController *viewVC = [[ViewController alloc]init];
    NSLog(@"改变前的viewVC：%@",viewVC);

    unsigned int count = 0;
    Ivar *vars = class_copyIvarList([ViewController class], &count);

    Ivar ivv = vars[0]; //从第一个方法getAllVariable中输出的控制台信息，我们可以看到实例属性。
    object_setIvar(viewVC, ivv, @"world"); //属性被强制改为world。
    
    NSLog(@"改变之后的viewVC：%@",viewVC);

}

+ (void)addNewMethod
{
    /* 动态添加方法：
     第一个参数表示Class cls 类型；
     第二个参数表示待调用的方法名称；
     第三个参数(IMP)myAddingFunction，IMP一个函数指针，这里表示指定具体实现方法myAddingFunction；
     第四个参数表方法的参数，0代表没有参数；
     */
    ViewController *viewVC = [[ViewController alloc]init];

    class_addMethod([viewVC class], @selector(myNewMethod), (IMP)addingMethod, 0);
    //调用方法
    [viewVC performSelector:@selector(myNewMethod)];
}

- (void)myNewMethod
{

}
//具体的实现（方法的内部都默认包含两个参数Class类和SEL方法，被称为隐式参数。）
int addingMethod(id self, SEL _cmd){
    NSLog(@"已新增方法:myNewMethod");
    
    return 1;
}

+ (void)exchangeMethod
{
    ViewController *viewVC = [[ViewController alloc]init];

    Method method1 = class_getInstanceMethod([viewVC class], @selector(method1));
    Method method2 = class_getInstanceMethod([viewVC class], @selector(method2));
    
    //交换方法
    method_exchangeImplementations(method1, method2);
    
    [viewVC method1];
}


#pragma mark - 增加隐藏键盘按钮
+ (void)hideKeyboard:(UITextField *)textfield {
    //为键盘增加工具栏
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    [topView setBarStyle:UIBarStyleDefault];
    [textfield setInputAccessoryView:topView];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 5, 40, 30);
    [btn addTarget:self action:@selector(dismissKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"closed"] forState:UIControlStateNormal];
    
    //将TextField绑定到button上，kTextField要和UITextField创建的对象名一致
    /*
     第一个参数是需要添加属性的对象；
     第二个参数是属性的key;
     第三个参数是属性的值;
     第四个参数是使用策略，是一个枚举值，类似@property属性创建时设置的关键字，可从命名看出各枚举的意义；
     */
    objc_setAssociatedObject(btn, kTextField, textfield, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //UIBarButtonSystemItemFlexibleSpace自动调节按钮间距
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    

    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:leftBtn,rightBtn,nil];
    
    [topView setItems:buttonsArray];
}

+ (void)dismissKeyBoard:(UIButton *)button{
    //获取button上对应的属性
    [objc_getAssociatedObject(button, kTextField) resignFirstResponder];
}




@end
