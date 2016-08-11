//
//  QCSearchViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/20.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCSearchViewController.h"
#import "QCUtilsMacro.h"

@interface QCSearchViewController ()

@property (nonatomic, strong) UISearchBar *searchBar;
//@property (nonatomic, strong) UITextField *searchTextField;

@end

@implementation QCSearchViewController

#pragma mark - lazy loading...
///** 初始化搜索框 */
//- (UITextField *)searchTextField{
//    if (!_searchTextField) {
//        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 65, 28)];
//        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
//        UIImageView *searchIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,27.5, 10)];
//        searchIcon.contentMode =  UIViewContentModeCenter;
//        [searchIcon setImage:[UIImage imageNamed:@"搜索"]];
//        _searchTextField.leftView = searchIcon;
//        _searchTextField.textColor = [UIColor whiteColor];
//        _searchTextField.placeholder = @"搜索商品";
//        [_searchTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//        _searchTextField.font = [UIFont systemFontOfSize:13];
//        _searchTextField.tintColor = [UIColor whiteColor];
//        _searchTextField.layer.cornerRadius = 3.0;
//        _searchTextField.layer.masksToBounds = YES;
//        _searchTextField.backgroundColor = HexColorAndAlpha(@"dddddd", .5);
//        [_searchTextField addTarget:self action:@selector(clickSearchTextField) forControlEvents:UIControlEventEditingDidBegin];
//    }
//    return _searchTextField;
//}

#pragma mark - life cycle...

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupNavigationItem];
}

#pragma mark - custom action

- (void)setupNavigationItem{
    self.navigationItem.leftBarButtonItem = ({
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 65, 28)];
        self.searchBar.placeholder = @"搜索用户名或IDX";
        [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
    });
    
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
        [cancelBtn setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
        cancelBtn;
    });
}

- (void)cancelClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
