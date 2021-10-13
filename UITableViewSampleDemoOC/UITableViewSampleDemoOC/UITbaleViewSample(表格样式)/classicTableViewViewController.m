//
//  classicTableViewViewController.m
//  UITableViewSampleDemoOC
//
//  Created by BruceYou on 2021/10/13.
//

#import "classicTableViewViewController.h"
#import "MJRefresh.h"
///  经典的无边Table 有headV footerV
@interface classicTableViewViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *dataArray;
    NSInteger pageIndex;
    NSInteger pageCount;
}


@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *tableHeaderView;
@property (strong, nonatomic) UIView *tableFooterView;

@end

@implementation classicTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
    [self initData];
    [self initUI];
    

    // 启动下拉刷新
    [self.tableView.mj_header beginRefreshing];
    

}
//UICustom BY 自定义样式 导航栏 NavigationBar
-(void)createNavigationBar{
    self.title = @"经典的表格样式";
    UIImage *barBg = [UIImage imageNamed:@"navigationBarBG"];
    /* :UIEdgeInsetsMake(100, 0, 0, 0)  100 表示图片前面高度为100的像素不拉升 左右宽度会拉升  UIImageResizingModeStretch 水平方式拉升 垂直方向 前面100 不拉升*/
    barBg = [barBg resizableImageWithCapInsets:UIEdgeInsetsMake(100, 0, 0, 0) resizingMode:UIImageResizingModeStretch]; //UIImageResizingModeStretch 拉升
//    设置导航栏的背景图片
    [self.navigationController.navigationBar setBackgroundImage:barBg forBarMetrics:UIBarMetricsDefault];
}

- (void)injected {
    [_tableView removeFromSuperview];
    _tableView = nil;
    [self viewDidLoad];
}

- (void)reloadViewAnimated {
    self->pageIndex = 0;
//    _tableView.tabAnimated.canLoadAgain = YES;
//    [_tableView tab_startAnimationWithCompletion:^{
//        [self updatetDataSource ];
//    }];
}

#pragma mark - Target Methods

/**
 下拉 更新数据
 */
- (void)updatetDataSource{
    [self initData];
    [self addData];
    // 停止动画,并刷新数据
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];

}

- (void)loadMoreDataSource {
    [self addData];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)addData {
    for (int i = 0; i < pageCount; i ++) {
        [dataArray addObject:[NSString stringWithFormat:@"这里是测试数据%ld",(long)(i+1+pageIndex*pageCount)]];
    }
    pageIndex++;
}

#pragma mark - UITableViewDelegate & Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"TestTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = dataArray[indexPath.row];
//    [cell initWithData:dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Initize Methods

/**
 load data
 加载数据
 */
- (void)initData {
    pageIndex = 0;
    pageCount = 10;
    dataArray = [NSMutableArray array];
}

/**
 initize view
 视图初始化
 */
- (void)initUI {
    [self.view addSubview:self.tableView];
}

#pragma mark - Lazy Methods
-(UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    }
    return _tableHeaderView;
}

-(UIView *)tableFooterView{
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    }
    return _tableFooterView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        
        
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.tableFooterView = self.tableFooterView;

        
        //下拉刷新01-默认

        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           //Call this Block When enter the refresh status automatically
                    [self updatetDataSource];
        }];
        
        //拉动刷新 - 上拉加载
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock: ^{
            [self loadMoreDataSource];
        }];

    }
    return _tableView;
}



@end
