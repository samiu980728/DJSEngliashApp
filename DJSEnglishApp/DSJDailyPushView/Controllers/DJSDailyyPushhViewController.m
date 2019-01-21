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
    _dataMessageList = [NSMutableArray arrayWithObjects:@"1",@"11",@"2",@"22",@"#",@"3",@"33",@"4",@"44",@"ff",@"a",@"aaa",@"555",@"666",nil];
    
    self.definesPresentationContext = YES;
    [self searchControllerLayout];
}

 - (void)viewDidLayoutSubviews
{
    //[_searchController.searchBar setFrame: CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, 200, 44.0)];
}

- (void)searchControllerLayout
{
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
//    self.mainTableView.frame = CGRectMake(0, 0, 300, 44)
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchBar.placeholder = @"请输入美文所包含单词";
    _searchController.searchResultsUpdater = self;
    //使其背景暗淡 当陈述时
    _searchController.dimsBackgroundDuringPresentation = NO;
    //隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    NSLog(@"self.searchController.searchBar.frame.size.width = %f",self.searchController.searchBar.frame.size.width);
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    NSLog(@"self.searchController.searchBar.frame.origin.x = %f, self.searchController.searchBar.frame.origin.y = %f",self.searchController.searchBar.frame.origin.x,self.searchController.searchBar.frame.origin.y);
    
    //改变系统自带 cancel 为取消
    [self.searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    //表头视图为searchController的searchBar
    self.mainTableView.tableHeaderView = self.searchController.searchBar;
    
#pragma mark 下面这样为什么不行？？？
//    [self.searchController.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        //make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.top.equalTo(self.view.mas_top).mas_offset(20);
//        make.width.equalTo(self.view.mas_width);
//        make.height.mas_equalTo(44.0);
//    }];
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
    //用户输入到搜索栏中的文字
    NSString * searchString = [self.searchController.searchBar text];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchString];
    if (self.searchMessageList != nil) {
        [self.searchMessageList removeAllObjects];
    }
    //过滤数据
    self.searchMessageList = [NSMutableArray arrayWithArray:[_dataMessageList filteredArrayUsingPredicate:predicate]];
    //刷新表格
    [self.mainTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active) {
        return _searchMessageList.count;
    } else {
        return 0;
    }
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
    [self transitionWithType:@"suckEffect" withSubType:subTypeString forView:self.view];
    UIView * superView = cancelButton.superview;
    [superView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
