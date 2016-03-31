//
//  XWImageManage.m
//  XWFunny
//
//  Created by wyy on 16/3/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "XWImageManage.h"
#import "PhotoView.h"
@interface XWImageManage()

@end
@implementation XWImageManage
+ (XWImageManage *)shareInstance{
    static XWImageManage *xwImageManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xwImageManage = [[XWImageManage alloc] init];
        
    });
    return xwImageManage;
}

- (id)init{
    if (self = [super init]) {
        //初始化
        _photoView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    }
    return self;
}



@end
