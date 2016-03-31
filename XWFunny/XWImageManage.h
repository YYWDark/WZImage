//
//  XWImageManage.h
//  XWFunny
//
//  Created by wyy on 16/3/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoView.h"
@interface XWImageManage : NSObject
@property (nonatomic , strong)PhotoView *photoView;
+ (XWImageManage *)shareInstance;

@end
