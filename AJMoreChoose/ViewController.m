//
//  ViewController.m
//  AJMoreChoose
//
//  Created by zhundao on 2017/8/31.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+UIButton_RightNav.h"
#import "isReadView.h"
#define kColorA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
//239 239 245

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,readDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *dataArray;
/*! 多选弹出的视图 */
@property(nonatomic,strong)isReadView *readView;
/*! 右边导航栏按钮 */
@property(nonatomic,strong)UIButton *navButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorA(239, 239, 245, 1);
    [self.view addSubview:self.tableView];
    [self createRight];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = kColorA(239, 239, 245, 1);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.rowHeight = 50 ;
    }
    return _tableView;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"这是我的第1条信息",@"这是我的第2条信息",@"这是我的第3条信息",@"这是我的第4条信息",@"这是我的第5条信息",@"这是我的第6条信息",@"这是我的第7条信息",@"这是我的第8条信息",@"这是我的第9条信息",@"这是我的第10条信息",@"这是我的第11条信息",@"这是我的第12条信息",@"这是我的第13条信息",@"这是我的第14条信息"];
    }
    return _dataArray;
}
- (isReadView *)readView{
    if (!_readView) {
        _readView = [[isReadView alloc]init];
    }
    return _readView;
}
-(UIButton *)navButton{
    if (!_navButton) {
        _navButton = [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 40, 30) WithImageName:nil Withtarget:self Selector:@selector(edit)];
        [_navButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_navButton setTitleColor:kColorA(11, 120, 205, 1) forState:UIControlStateNormal];
        
    }
    return _navButton;
}
#pragma mark -------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    /*! 选中样式 不能为none，否则不会出现勾勾 */
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    /*! 多选的时候的背景view */
    cell.multipleSelectionBackgroundView = [[UIView alloc]init];
    /*! 设置多选勾勾背景颜色 */
    cell.tintColor = kColorA(11, 120, 205, 1);
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"这是第%li行",(long)indexPath.row+1];
    return cell;
}
#pragma mark -------UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView.editing) {
        [self changeButtonColor:YES];
        return;
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.tableView indexPathsForSelectedRows].count==0) {
        [self changeButtonColor:NO];
    }
}
/*! 改变标记已读按钮的颜色和点击状态 */
- (void)changeButtonColor : (BOOL)isShowBlue{
    if (isShowBlue) {
        _readView.chooseButton.userInteractionEnabled = YES;
        [_readView.chooseButton setTitleColor:kColorA(11, 120, 205, 1) forState:UIControlStateNormal];
    }else{
        _readView.chooseButton.userInteractionEnabled = NO;
        [_readView.chooseButton setTitleColor:kColorA(203, 203, 203, 1) forState:UIControlStateNormal];
    }
}

#pragma mark---编辑
- (void)createRight{
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:self.navButton];
    self.navigationItem.rightBarButtonItem = item;
}
/*! 编辑 */
- (void)edit{
    if (self.tableView.editing) {
        [self endEdit];
    }else{
        [self beginEdit];
    }
}
/*! 结束编辑 */
- (void)endEdit{
    /*! 结束编辑时 改变按钮名称 */
    [_navButton setTitle:@"编辑" forState:UIControlStateNormal];
    /*! 取消多选和取消编辑 */
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    self.tableView.editing = NO;
    /*! 还原tableview的frame */
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    /*! 取消_readView的代理 */
    _readView.readDelegate = nil;
    /*! 弹出 */
    [_readView fadeOut];
}
/*! 开始编辑 */
- (void)beginEdit{
    /*! 和上面相反 */
    [_navButton setTitle:@"取消" forState:UIControlStateNormal];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.editing = YES;
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-44);
    [self.view addSubview:self.readView];
    _readView.readDelegate = self;
    [_readView fadeUp];
}

#pragma mark----readDelegate

- (void)readSome{
    /*! 遍历数组获取当前多选的位置 */
    @autoreleasepool {
        [[self.tableView indexPathsForSelectedRows]enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            /*! 做操作 */
            NSLog(@"已读第%li条信息",obj.row);
        }];
    }
    [_tableView reloadData];
    /*! 结束编辑 */
    [self endEdit];
}

- (void)readAll{
    /*! 遍历所有数据，将其设置为打勾状态 */
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }];
    /*! 改变按钮颜色 */
    [self changeButtonColor:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_readView) {
        [_readView removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
