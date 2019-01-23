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
@property (nonatomic, strong) UITableView * mainTableView;

@property (nonatomic, strong) UISearchController * searchController;

@property (nonatomic, strong) NSMutableArray * dataMessageList;

@property (nonatomic, strong) NSMutableArray * searchMessageList;

@property (nonatomic, strong) UIScrollView * scrollView;
@end
