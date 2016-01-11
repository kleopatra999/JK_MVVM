//
//  JKViewController.m
//  JK_MVVM
//
//  Created by zhang_jk on 16/1/10.
//  Copyright © 2016年 pactera. All rights reserved.
//

#import "JKViewController.h"
#import "JKModel.h"
#import "JKCell.h"
#import "JKTableDataDelegate.h"
#import "UITableViewCell+Extension.h"
#import "JKViewModel.h"
#import "JKBaseViewModel.h"
#import "AppDelegate.h"

static NSString *const MyCellIdentifier = @"JKCell";

@interface JKViewController ()
@property (nonatomic, strong)JKTableDataDelegate *tableHander;

@end

@implementation JKViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"网络异常"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:cancelAction];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIViewController *root = app.window.rootViewController;
    [root presentViewController:alert animated:YES completion:nil];
    
}

- (void)setupTableView
{
    __weak typeof(self) weakSelf = self;
    
    TableViewCellConfigureBlock configure = ^(NSIndexPath *indexPath,JKModel *obj, UITableViewCell *cell){
        [cell configure:cell customObj:obj indexPath:indexPath];
    
    };
    
    DidSelectCellBlock selectBlock = ^(NSIndexPath *indexPath, JKModel *obj){
        [weakSelf.table deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"click row : %@",@(indexPath.row));
        
    };
    
    JKViewModel *model =[[JKViewModel alloc] init];
    
    self.tableHander = [[JKTableDataDelegate alloc] initWithSelFriendsDelegate:model
                                                                cellIdentifier:MyCellIdentifier
                                                            configureCellBlock:configure
                                                               cellHeightBlock:nil
                                                                didSelectBlock:selectBlock];
   
    [self.tableHander handelTableViewDatasourceAndDelegate:_table];
    
    
}
@end