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

///阅读卡片 主要
@property (nonatomic, strong) DJSEnglishCardImageView * englishCardImageView;

///阅读卡片 左侧
@property (nonatomic, strong) DJSEnglishCardImageView * englishLeftCardImageView;

///阅读卡片 右侧
@property (nonatomic, strong) DJSEnglishCardImageView * englishRightCardImageView;

///scrollView外部的包裹view 负责再上面添加各种需要的控件，用于Masonory布局
@property (nonatomic, strong) UIView * contrainView;

///按下取消按钮时不去执行srollViewdidScroll
@property (nonatomic, assign) BOOL cancelButtonNotAllowSrollViewdidScroll;

///记录当前展示的照片次序 (可以理解你正在展示的是第几张照片  从0 开始)
@property (nonatomic, assign) NSInteger currentIndex;

///记录左边照片展示的次序
@property (nonatomic, assign) NSInteger currentLeftIndex;

///记录右边照片展示的次序
@property (nonatomic, assign) NSInteger currentRightIndex;

@end
