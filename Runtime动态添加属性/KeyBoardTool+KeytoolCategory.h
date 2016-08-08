//
//  KeyBoardTool+KeytoolCategory.h
//  Runtime动态添加属性
//
//  Created by 刘浩浩 on 16/8/8.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "KeyBoardTool.h"

@interface KeyBoardTool (KeytoolCategory)
/**
 *  增加属性（字符串类型）
 */
@property (nonatomic,strong)NSString *newVariable;
/**
 *  增加属性（常量）
 */
@property (nonatomic,assign)float height;


@end
