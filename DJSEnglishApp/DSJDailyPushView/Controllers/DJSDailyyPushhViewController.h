//
//  DJSDailyyPushhViewController.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/1/21.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
@class DJSSearchYourCollectionMessageView;
@class DJSEnglishCardImageView;
@interface DJSDailyyPushhViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating,UIScrollViewDelegate>
///搜索内容所在的tableView
@property (nonatomic, strong) UITableView * mainTableView;

///搜索栏
@property (nonatomic, strong) UISearchController * searchController;

///源内容
@property (nonatomic, strong) NSMutableArray * dataMessageList;

///搜索后展示的内容
@property (nonatomic, strong) NSMutableArray * searchMessageList;

///滚动视图
@property (nonatomic, strong) UIScrollView * scrollView;

///判断取消键是否被选中
@property (nonatomic, assign) BOOL cancelButtonIfSelected;

///阅读卡片
@property (nonatomic, strong) DJSEnglishCardImageView * englishCardImageView;
@end
