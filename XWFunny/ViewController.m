
//  ViewController.m
//  XWFunny
//
//  Created by wyy on 16/3/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "ViewController.h"
#import "XWImageManage.h"

@interface ViewController (){
    NSMutableArray *_nameArr;
    NSMutableArray *_imageArr;
}
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UIActivityIndicatorView *indicator;
@end

@implementation ViewController
#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    self.edgesForExtendedLayout = NO;

    
    [self.view addSubview:self.indicator];
    XWImageManage *xwImageManage = [XWImageManage shareInstance];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"name" ofType:@"plist"];
    _nameArr= [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    //让数据显的多一点
    for (int i = 0; i < 3; i++) {
        [_nameArr addObjectsFromArray:_nameArr];
    };
    
    _imageArr = [NSMutableArray array];
    //后台去生成图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSString *nameStr in _nameArr) {
            xwImageManage.photoView.peopleName = nameStr;
            xwImageManage.photoView.imageSize = CGSizeMake(40, 40);
            xwImageManage.photoView.disable = random()%2;
            [_imageArr addObject:xwImageManage.photoView.headImage];
        }
        
    dispatch_async(dispatch_get_main_queue(), ^{
            [_indicator removeFromSuperview];
            [self.view addSubview:self.tableView];
            
            
        });
    });

}


- (void)viewDidLayoutSubviews{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
         [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabaleView Delegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(velocity.y > 0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _imageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"UITableViewCell"];
        
        
    }
    cell.imageView.image = _imageArr[indexPath.row];
    cell.textLabel.text = _nameArr[indexPath.row];
    return cell;
}


#pragma mark - Get
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height + 64) style:0];
        _tableView.rowHeight  = 66.0f;
        _tableView.delegate   = self;
        _tableView.dataSource = self;


        
    }
    return _tableView;
}

- (UIActivityIndicatorView *)indicator{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicator.frame= CGRectMake(0, 0, 80.0f, 80.0f);
        _indicator.center = self.view.center;
        _indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
        _indicator.clipsToBounds = YES;
        _indicator.layer.cornerRadius = 6;
        [_indicator startAnimating];
        [self.view addSubview:_indicator];
    }
    return _indicator;
}

@end
