//
//  DJSDailyyPushhViewController.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/1/21.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSDailyyPushhViewController.h"

@interface DJSDailyyPushhViewController ()

@end

@implementation DJSDailyyPushhViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"美文欣赏";
    self.view.backgroundColor = [UIColor yellowColor];
    _dataMessageList = [NSMutableArray arrayWithObjects:@"1",@"11",@"2",@"22",@"#",@"3",@"33",@"4",@"44",@"ff",@"a",@"aaa",@"555",@"666",nil];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self searchControllerLayout];
}

- (void)searchControllerLayout
{
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.separatorStyle = UITableViewCellEditingStyleNone;
//    self.mainTableView.frame = CGRectMake(0, 0, 300, 44)
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    _searchController.view.backgroundColor = [UIColor yellowColor];
    _searchController.searchBar.placeholder = @"请输入美文所包含单词";
    _searchController.searchResultsUpdater = self;
    //使其背景暗淡 当陈述时  ||  当搜索框激活时, 是否添加一个透明视图
    _searchController.dimsBackgroundDuringPresentation = NO;
    // 当搜索框激活时, 是否隐藏导航条
    _searchController.hidesNavigationBarDuringPresentation = YES;
//    这行代码是声明，哪个viewcontroller显示UISearchController
    self.definesPresentationContext = YES;
    
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    //改变系统自带 cancel 为取消
    [self.searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    //表头视图为searchController的searchBar
    self.mainTableView.tableHeaderView = self.searchController.searchBar;
    
#pragma mark 下面这样为什么不行？？？
//    [self.searchController.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right).offset(-100);
//        make.top.equalTo(self.view.mas_top).mas_offset(50);
//        make.height.mas_equalTo(100);
//    }];
    
    //[[self.searchController.searchBar.subviews objectAtIndex:0] removeFromSuperview];
    for (UIView * subView in self.searchController.searchBar.subviews) {
        for (UIView * grandView in subView.subviews) {
            if ([grandView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                grandView.alpha = 0.0f;
            } else if ([grandView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                NSLog(@"Keep textfiedld bkg color");
            } else {
                grandView.alpha = 0.0f;
            }
        }
    }
    UITextField * searchFiled = [self.searchController.searchBar valueForKey:@"searchField"];
    if (searchFiled) {
        //R:78 G:187 B:183
        [searchFiled setBackgroundColor:[UIColor colorWithRed:78 green:187 blue:183 alpha:1]];
        searchFiled.layer.cornerRadius = 14.0f;
        searchFiled.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor yellowColor]);
        searchFiled.layer.borderWidth = 1;
        searchFiled.layer.masksToBounds = YES;
    }
    if (!self.searchController.active) {
        NSLog(@"处于不活跃状态");
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cellFlag";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (self.searchController.active) {
        cell.textLabel.text = self.searchMessageList[indexPath.row];
    } else {
        cell.textLabel.text = self.dataMessageList[indexPath.row];
    }
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
//    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
//        [self.searchController.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view.mas_left);
//            make.right.equalTo(self.view.mas_right).offset(-100);
//            make.top.equalTo(self.view.mas_top).mas_offset(20);
//            make.height.mas_equalTo(100);
//        }];
    
    //用户输入到搜索栏中的文字
    NSString * searchString = [self.searchController.searchBar text];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchString];
    if (self.searchMessageList != nil) {
        [self.searchMessageList removeAllObjects];
    }
    //过滤数据
    _searchMessageList = [NSMutableArray arrayWithArray:[_dataMessageList filteredArrayUsingPredicate:predicate]];
    //刷新表格
    [self.mainTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active) {
//        NSUInteger x = _searchMessageList.count;
        return _searchMessageList.count;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchController.active) {
        NSLog(@"search中的 %@被选中",_searchMessageList[indexPath.row]);
        DJSSearchYourCollectionMessageView * searchCollectionView = [[DJSSearchYourCollectionMessageView alloc] init];
        
        //设置动画类型
        NSString * subTypeString;
        subTypeString = @"kCATransitionFromLeft";
        [searchCollectionView.cancelButton addTarget:self action:@selector(pressCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [self transitionWithType:@"rippleEffect" withSubType:subTypeString forView:self.view];
        
        [self.view addSubview:searchCollectionView];
        
        [searchCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(50);
            make.right.equalTo(self.view.mas_right).offset(-50);
            make.top.equalTo(self.view.mas_top).offset(50);
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        }];
    } else {
        NSLog(@"下拉清单中的 %@被选中",_dataMessageList[indexPath.row]);
    }
}

//封装动画
- (void)transitionWithType:(NSString *)type withSubType:(NSString *)subType forView:(UIView *)view
{
    CATransition * animation = [CATransition animation];
    //设置运动时间
    animation.duration = 0.7f;
    animation.type = type;
    if (subType != nil) {
        animation.subtype = subType;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

//UIview实现动画
- (void)animationWithView:(UIView *)view withAnimationTransition:(UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:0.7f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

- (void)pressCancelButton:(UIButton *)cancelButton
{
    NSString * subTypeString;
    subTypeString = @"kCATransitionFromTop";
    UIView * superView = cancelButton.superview;
    superView.backgroundColor = [UIColor whiteColor];
    NSLog(@"superView = %@",superView);
    //[self transitionWithType:@"suckEffect" withSubType:subTypeString forView:self.view];
    [self transitionWithType:@"suckEffect" withSubType:subTypeString forView:self.view];
    [superView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
//明天：搜索框定位准确 解决搜索框占满整个屏幕的问题
//明天：可触控 拿到接口 做双击单词翻译这个功能







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
