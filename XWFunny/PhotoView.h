//
//  PhotoView.h
//  XWFunny
//
//  Created by wyy on 16/3/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIView
@property (nonatomic ,copy) NSString *peopleName;
@property (nonatomic ,strong )UIImage *headImage;
@property (nonatomic, assign) BOOL disable; //def is NO
@property (nonatomic, assign) BOOL newTagEnable; //def is NO
@property (nonatomic ,assign)CGSize imageSize;//默认为40*40
@end
