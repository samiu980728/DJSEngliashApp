//
//  DJSDailyyPushhViewController.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/1/21.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSDailyyPushhViewController.h"
#import "DJSSearchYourCollectionMessageView.h"
#import "DJSEnglishCardImageView.h"
@interface DJSDailyyPushhViewController ()

@end

@implementation DJSDailyyPushhViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"美文欣赏";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"4.jpeg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor darkTextColor]}];
    self.view.backgroundColor = [UIColor yellowColor];
    _dataMessageList = [NSMutableArray arrayWithObjects:@"1",@"11",@"2",@"22",@"#",@"3",@"33",@"4",@"44",@"ff",@"a",@"aaa",@"555",@"666",nil];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self searchControllerLayout];
//    [self searchControllerLayoutSubViews];
//    [self addImageView];
    _cancelButtonIfSelected = NO;
    _cancelButtonNotAllowSrollViewdidScroll = NO;
    self.currentIndex = 0;
    self.currentLeftIndex = 0;
    self.currentRightIndex = 0;
}

- (void)addImageView
{
    self.englishLeftCardImageView = [[DJSEnglishCardImageView alloc] initWithFrame:CGRectMake(10, 170, 214, 260)];
    self.englishLeftCardImageView.image = [UIImage imageNamed:@"6.jpg"];
    self.englishLeftCardImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.englishLeftCardImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"6.jpg"]]];
    self.englishLeftCardImageView.userInteractionEnabled = YES;

    [self.scrollView addSubview:self.englishLeftCardImageView];
    
    self.englishRightCardImageView = [[DJSEnglishCardImageView alloc] initWithFrame:CGRectMake(190, 170, 214, 260)];
    self.englishRightCardImageView.image = [UIImage imageNamed:@"7.jpg"];
    self.englishRightCardImageView.contentMode = UIViewContentModeScaleAspectFill;
    //[self.englishRightCardImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"7.jpg"]]];
    self.englishRightCardImageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.englishRightCardImageView];
    
    self.englishCardImageView = [[DJSEnglishCardImageView alloc] initWithFrame:CGRectMake(100, 150, 214, 300)];
    self.englishCardImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.englishCardImageView.image = [UIImage imageNamed:@"5.jpeg"];
    [self getLeftGestureRecognizeIimageView:self.englishCardImageView];
    [self getRightGestureRecognizeIimageView:self.englishCardImageView];
    //[self.englishCardImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"5.jpeg"]]];
    self.englishCardImageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.englishCardImageView];
//    _englishCardImageView = [[DJSEnglishCardImageView alloc] init];
//    [self.scrollView addSubview:_englishCardImageView];
//    [_englishCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_left).offset(90);
//        make.right.mas_equalTo(self.view.mas_right);
//        make.top.mas_equalTo(self.view.mas_top).offset(100);
//        make.height.mas_equalTo(200);
//    }];
}

//生成左手势
- (void)getLeftGestureRecognizeIimageView:(UIImageView *)englishCardImageView
{
    UISwipeGestureRecognizer * leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftAction:)];
    //默认属性direction(方向)只有向右滑动    所以要为左滑动更改下属性  向右是默认 可以不改
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [englishCardImageView addGestureRecognizer:leftGesture];
}

//生成右手势
- (void)getRightGestureRecognizeIimageView:(UIImageView *)englishCardImageView
{
    UISwipeGestureRecognizer * rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction:)];
    [englishCardImageView addGestureRecognizer:rightGesture];
}

//# 左滑触及的方法 目的是 上一张照片 给自己定义的方法传参数标记1
- (void)leftAction:(UISwipeGestureRecognizer *)sender
{
    [self transitionAnimation:1];
}

//# 右滑触及的方法 目的是 下一张照片 给自己定义的方法传参数标记0
- (void)rightAction:(UISwipeGestureRecognizer *)sender
{
    [self transitionAnimation:0];
}

- (void)transitionAnimation:(BOOL)isNext
{
    NSString * subtypeString;
    if (isNext) {
        subtypeString = kCATransitionFromLeft;
    } else {
        subtypeString = kCATransitionFromRight;
    }
    [self transitionWithType:kCATransitionReveal withSubType:subtypeString forView:self.englishCardImageView];
    self.englishCardImageView.image = [self getImage:isNext];
    self.englishLeftCardImageView.image = [self getLeftImage:isNext];
    self.englishRightCardImageView.image = [self getRightImage:isNext];
}

- (UIImage *)getImage:(BOOL)isNext
{
    if (isNext) {
        self.currentIndex = (self.currentIndex+1) % 3;
    } else {
        self.currentIndex = (self.currentIndex-1+5) % 3;
    }
    NSInteger currentInteger = self.currentIndex + 5;
    NSString * imageName;
    if (currentInteger == 5) {
        imageName = [NSString stringWithFormat:@"%ld.jpeg",currentInteger];
    } else {
        imageName = [NSString stringWithFormat:@"%ld.jpg",currentInteger];
    }
    return [UIImage imageNamed:imageName];
}

- (UIImage *)getLeftImage:(BOOL)isNext
{
    self.currentLeftIndex = self.currentIndex - 1;
    NSInteger currentInteger = self.currentLeftIndex + 5;
    NSString * imageName;
    if (currentInteger == 5) {
        imageName = [NSString stringWithFormat:@"%ld.jpeg",currentInteger];
    } else {
        imageName = [NSString stringWithFormat:@"%ld.jpg",currentInteger];
    }
    return [UIImage imageNamed:imageName];
}

- (UIImage *)getRightImage:(BOOL)isNext
{
    if (self.currentIndex < 7) {
        self.currentRightIndex = self.currentIndex + 1;
    } else {
        self.currentRightIndex = self.currentIndex;
    }
    NSInteger currentInteger = self.currentRightIndex + 5;
    NSString * imageName;
    if (currentInteger == 5) {
        imageName = [NSString stringWithFormat:@"%ld.jpeg",currentInteger];
    } else {
        imageName = [NSString stringWithFormat:@"%ld.jpg",currentInteger];
    }
    return [UIImage imageNamed:imageName];
}

- (void)setScrollViewAndMasonryByContrainView
{
    //这里面的mainTableView 就相当于那个demo里的contrainView
    //错了 当不点击搜索时 mainTableView 的尺寸时很小的
    //所以还得创建一个 contrainView 来包裹上面的其他view
    //这些view 包括： bottomView,_englishCardImageView 等
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor blueColor];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.englishCardImageView.alpha = 0.5;
    self.englishLeftCardImageView.alpha = 0.5;
    self.englishRightCardImageView.alpha = 0.5;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    float orginScrollViewY = self.scrollView.contentOffset.y;
    if (orginScrollViewY > 100) {
        //self.navigationController.navigationBar.hidden = YES;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        self.englishCardImageView.alpha = 0.5;
        self.englishLeftCardImageView.alpha = 0.5;
        self.englishRightCardImageView.alpha = 0.5;
        self.mainTableView.tableHeaderView = nil;
        UIBarButtonItem * searchBarButton = [[UIBarButtonItem alloc] initWithCustomView:_searchController.searchBar];
        self.navigationItem.rightBarButtonItem = searchBarButton;
    } else {
        _searchController.hidesNavigationBarDuringPresentation = YES;
        self.navigationItem.rightBarButtonItem = nil;
        self.mainTableView.tableHeaderView = _searchController.searchBar;
        self.navigationController.navigationBar.hidden = NO;
        self.englishCardImageView.alpha = 1.0;
        self.englishLeftCardImageView.alpha = 1.0;
        self.englishRightCardImageView.alpha = 1.0;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //隐藏导航栏
    float orginY = self.englishCardImageView.frame.origin.y;
    float orginScrollViewY = self.scrollView.contentOffset.y;
    NSLog(@"orginScrollViewY = %f",orginScrollViewY);
#pragma mark Request: when englishCardImageView's orgin y is less than 60 ,searchBar must move to the top of the view and replace the nagivationBar
//    int ifZeroOriginY = orginScrollViewY;
//    if (ifZeroOriginY != 0) {
    
    if (orginScrollViewY > 100) {
#pragma mark Request: let searchBar move to the nagiavationBar as a rightBarButtonItem, meanwhile let the mainTableView's tableHeaderView disappear
        self.mainTableView.tableHeaderView = nil;
        UIBarButtonItem * searchBarButton = [[UIBarButtonItem alloc] initWithCustomView:_searchController.searchBar];
        self.navigationItem.rightBarButtonItem = searchBarButton;
        
        //self.navigationController.navigationBar.hidden = YES;
        //当搜索框被激活时，不必在隐藏导航栏 因为现在搜索框在导航栏上
        _searchController.hidesNavigationBarDuringPresentation = NO;
        self.englishCardImageView.alpha = 0.5;
        self.englishLeftCardImageView.alpha = 0.5;
        self.englishRightCardImageView.alpha = 0.5;
        [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.view.mas_width);
            make.height.mas_equalTo(50);
            make.top.mas_equalTo(self.view.mas_top);
        }];
    } else{
        #pragma mark question： 搜索框无故消失 是这四个之中的问题
        self.navigationItem.rightBarButtonItem = nil;
        if (!self.mainTableView.tableHeaderView) {
        self.mainTableView.tableHeaderView = _searchController.searchBar;
        }
        self.navigationController.navigationBar.hidden = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;

        self.englishCardImageView.alpha = 1.0;
        self.englishLeftCardImageView.alpha = 1.0;
        self.englishRightCardImageView.alpha = 1.0;
        [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.view.mas_width);
            make.height.mas_equalTo(50);
            make.top.mas_equalTo(self.view.mas_top);
        }];
    }
    
//    }
}

- (void)searchControllerLayout
{
    _scrollView = [[UIScrollView alloc] init];
    self.scrollView.contentSize = CGSizeMake(0, 1800);
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3.jpeg"]];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self addImageView];

#pragma mark:set up mainTableView
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    
#pragma mark explain: actually it is what you like to set value to mainTableView's backgroundColor or scrollView's backgroundColor,because mainTableView is on the scrollView ,when you do not search anything ,the mainTableView's surface have not anything on it ,so whether you like, there are same means.
    //self.mainTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3.jpeg"]];
    self.mainTableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    [self.scrollView addSubview:self.mainTableView];
    //[self.view addSubview:self.mainTableView];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    
#pragma mark:set up searchController
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchBar.placeholder = @"请输入美文所包含单词";
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.delegate = self;
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
    
#pragma mark  Request: why not work out?
//    [self.searchController.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right).offset(-100);
//        make.top.equalTo(self.view.mas_top).mas_offset(50);
//        make.height.mas_equalTo(100);
//    }];
   
#pragma mark:cancel the searchBar's grayColor backGround
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
#pragma mark:设置搜索框为圆角，改变搜索框背景颜色
    UITextField * searchFiled = [self.searchController.searchBar valueForKey:@"searchField"];
    if (searchFiled) {
        //R:78 G:187 B:183
        [searchFiled setBackgroundColor:[UIColor colorWithRed:78 green:187 blue:183 alpha:1]];
        searchFiled.layer.cornerRadius = 14.0f;
        searchFiled.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor yellowColor]);
        searchFiled.layer.borderWidth = 1;
        searchFiled.layer.masksToBounds = YES;
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
//    self.navigationItem.rightBarButtonItem = nil;
//    self.mainTableView.tableHeaderView = _searchController.searchBar;
//    self.navigationController.navigationBar.hidden = NO;
//    _searchController.hidesNavigationBarDuringPresentation = YES;
    _cancelButtonIfSelected = YES;
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
    //重新设置高度
    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(self.view.mas_width);
#pragma request: 还需要设置 tableView 的 backgroundColor 非clearColor!!!
    }];
    if (_cancelButtonIfSelected) {
        [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top);
            make.width.mas_equalTo(self.view.mas_width);
            make.height.mas_equalTo(50);
        }];
        NSLog(@"self.mainTableView.tableHeaderView = %@",self.mainTableView.tableHeaderView);
        NSLog(@"self.searchController.searchBar.placeholder = %@",self.searchController.searchBar.placeholder);
        self.mainTableView.tableHeaderView.hidden = NO;
    }
    _cancelButtonIfSelected = NO;
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


//使用contrainView作为中间层布局scorllView始终失败
- (void)searchControllerLayoutSubViews
{
    _scrollView = [[UIScrollView alloc] init];
    //self.scrollView.contentSize = CGSizeMake(0, 1800);
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3.jpeg"]];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
#pragma mark Request: set up contrainView who prefers to cover englishCardView & bottomView & ....
    self.contrainView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contrainView];
    [self.contrainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
#pragma mark:set up mainTableView
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.separatorStyle = UITableViewCellEditingStyleNone;
    //    [self.scrollView addSubview:self.mainTableView];
    [self.contrainView addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.contrainView);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    
#pragma mark: set up bottomView
    UILabel * bottomView = [[UILabel alloc] init];
    bottomView.backgroundColor = [UIColor yellowColor];
    [self.contrainView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contrainView);
        make.height.mas_equalTo(60);
        make.top.mas_equalTo(self.mainTableView.mas_bottom).offset(900);
    }];
    [self.contrainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bottomView.mas_bottom);
    }];
    
    NSLog(@"self.contrainView.bounds.size.height = %f self.contrainView.bounds.size.width = %f",self.contrainView.bounds.size.height,self.contrainView.bounds.size.width);
#pragma mark:set up searchController
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchBar.placeholder = @"请输入美文所包含单词";
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.delegate = self;
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
    
#pragma mark:取消搜索框自带灰色背景
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
#pragma mark:设置搜索框为圆角，改变搜索框背景颜色
    UITextField * searchFiled = [self.searchController.searchBar valueForKey:@"searchField"];
    if (searchFiled) {
        //R:78 G:187 B:183
        [searchFiled setBackgroundColor:[UIColor colorWithRed:78 green:187 blue:183 alpha:1]];
        searchFiled.layer.cornerRadius = 14.0f;
        searchFiled.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor yellowColor]);
        searchFiled.layer.borderWidth = 1;
        searchFiled.layer.masksToBounds = YES;
    }
}

#pragma mark Request:
//明天：搜索框定位准确 解决搜索框占满整个屏幕的问题
//明天：可触控 拿到接口 做双击单词翻译这个功能
#pragma mark 新一周
//注意搜索栏 搜索时还说有问题 如果输入1 显示的内容与图片重叠 则无法选中该内容
//应该在实时搜索时再创建一个界面来展示搜索界面 并把该界面覆盖在最外部   






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
