//
//  PhotoView.m
//  XWFunny
//
//  Created by wyy on 16/3/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "PhotoView.h"
#import "UIColor+XWAdd.h"
#import "UIImage+XWAdd.h"

@interface PhotoView()
@property (nonatomic ,strong) CALayer *colorBgLayer;
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UIImageView *headImageView;
@property (nonatomic ,strong) UIView  *tagView;

 
@end

@implementation PhotoView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
         _imageSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        [self.layer addSublayer:self.colorBgLayer];
        [self addSubview:self.nameLabel];
        [self addSubview:self.headImageView];
        [self addSubview:self.tagView];
    }
    return self;
}

#pragma mark - private method

/**
 *  根据昵称的最后一个汉字来判断所返回的背景颜色
 *
 *  @param string  昵称
 *  @param disable 判断在线或者离线的显示
 *
 *  @return 背景颜色
 */
- (UIColor *)_colorForString:(NSString *)string disable:(BOOL)disable{

   NSString *pureStr =     [self _filterChineseWord:string];
    if (pureStr.length == 0) {//如果账号没有汉子 直接返回默认的图像
        return nil;
    }
    
    if (disable)
    {
        return [UIColor flatGrayColor];
    }
    
    NSArray *bgColorArray = @[[UIColor colorWithHex:0xF4564C], [UIColor colorWithHex:0xEE9A34], [UIColor colorWithHex:0xEAC137], [UIColor colorWithHex:0x63BF40],
                              [UIColor colorWithHex:0x40ABE4], [UIColor colorWithHex:0x5C6BC0], [UIColor colorWithHex:0xC57BD2]];
    
    if (string.length == 0)
    {
        return bgColorArray[0];
    }
    
    NSString *chineseName = [self _filterChineseWord:string];
    NSString *lastChar = [chineseName substringFromIndex:chineseName.length-1];
    NSString *firstPinying = [[self transformToPinYin:lastChar] substringToIndex:1];
    const char *ch = [firstPinying cStringUsingEncoding:NSASCIIStringEncoding];
    if (ch == NULL)
    {
        return bgColorArray[0];
    }
    else
    {
        return bgColorArray[ch[0]%bgColorArray.count];
    }
    return nil;
}

- (void)_updateView{
    self.colorBgLayer.backgroundColor = [self _colorForString:self.peopleName disable:self.disable].CGColor;
    self.nameLabel.text = [self headSignStringForName:self.peopleName];
    
    
    [self headImage];
}

/**
 *  名字
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)headSignStringForName:(NSString *)name
{
    if (!name.length)
    {
        return @"";
    }
    
    NSString *pureStr = [self _filterChineseWord:name];
    
    if (!pureStr.length)
    {
        return [name substringToIndex:1];
    }
    else
    {
        return [pureStr substringFromIndex:pureStr.length-1];
    }
}

/**
 * 选出昵称中的汉字
 */
- (NSString *)_filterChineseWord:(NSString *)string{
    NSMutableString *newString = [NSMutableString string];
    for (NSInteger i=0; i<string.length; i++) {
        NSString *charStr = [string substringWithRange:NSMakeRange(i, 1)];
        if (!isascii(*[charStr cStringUsingEncoding:NSUTF8StringEncoding])) {
            [newString appendString:charStr];
        }
    }
    return newString;
}

/**
 *  拿到拼音的首字母
 *
 *  @param string
 *
 *  @return 
 */
- (NSString*)transformToPinYin : (NSString *)string
{
    NSMutableString *newStr = [NSMutableString stringWithString:string];
    CFRange range = CFRangeMake(0, newStr.length);
    CFStringTransform((CFMutableStringRef)newStr, &range, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)newStr, &range, kCFStringTransformStripCombiningMarks, NO);
    return newStr;
}

#pragma mark - Get and Setter
//- (CALayer *)whiteBgLayer{
//    if (!_whiteBgLayer ) {
//        _whiteBgLayer = [CALayer layer];
//        _whiteBgLayer.frame = self.bounds;
//        _whiteBgLayer.backgroundColor = [UIColor whiteColor].CGColor;
//    }
//    return _whiteBgLayer;
//}

- (CALayer *)colorBgLayer{
    if (!_colorBgLayer) {
        _colorBgLayer = [CALayer layer];
        _colorBgLayer.frame = self.bounds;
        _colorBgLayer.masksToBounds = YES;
        _colorBgLayer.cornerRadius = self.frame.size.height/2;
    }
    return _colorBgLayer;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:(int)(self.frame.size.height/2)];
        
    }
    return _nameLabel;
}

- (UIImage *)headImage{
    if (!([self _filterChineseWord:self.peopleName].length)) {//如果没有汉子就显示默认图像
        if (self.disable) {
            _headImage = [[UIImage imageNamed:@"offline.png"] imageByResizeToSize:_imageSize];
        }else{
            _headImage =   [[UIImage imageNamed:@"online.png"] imageByResizeToSize:_imageSize];
        }
    }else {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        _headImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _headImage =   [_headImage imageByRoundCornerRadius:self.frame.size.height corners:UIRectCornerAllCorners borderWidth:0 borderColor: nil borderLineJoin:kCGLineJoinRound];
        
    }
    return _headImage;
}


- (void)setPeopleName:(NSString *)peopleName{
    if (_peopleName != peopleName) {
        _peopleName = peopleName;
        [self _updateView];
    }
}

- (void)setImageSize:(CGSize)imageSize{
    if ((_imageSize.width != imageSize.width) && (_imageSize.height != imageSize.height)) {
        _imageSize.width   = imageSize.width;
        _imageSize.height  = imageSize.height;
        [self _updateView];
    }
}

- (void)setDisable:(BOOL)disable{
    if (_disable != disable) {
        _disable = disable;
        [self _updateView];
    }
}



@end
