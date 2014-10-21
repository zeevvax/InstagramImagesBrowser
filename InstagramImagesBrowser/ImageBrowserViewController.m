//
//  ImageBrowserViewController.m
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/18/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//

#import "ImageBrowserViewController.h"
#import "IBDataLoader.h"
#import "IBImageBrowserDataSource.h"
#import "ImageBrowserTableViewCell.h"
#import "IBImageViewerViewController.h"


static NSString *const ImageBrowserTableViewCellID = @"ImageBrowserTableViewCellID";

@interface ImageBrowserViewController () <UITableViewDataSource, UITableViewDelegate, IBImageBrowserDataSourceDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIRefreshControl *refreshControl;
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation ImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self setTitle:@"Image Browser"];
    // Do any additional setup after loading the view
    IBImageBrowserDataSource *dataSource = [IBImageBrowserDataSource new] ;
    dataSource.delegate = self;
    self.dataSource = dataSource;
    [self setupTableView];
    [self setupViewConstarints];
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.rowHeight = self.view.bounds.size.width + 20.0;
    [self.tableView registerClass:[ImageBrowserTableViewCell class] forCellReuseIdentifier:ImageBrowserTableViewCellID];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshConetnt:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    [self.refreshControl beginRefreshing];
}

- (void)setupViewConstarints{
    NSDictionary *viewsDictionary = @{@"tableView": self.tableView};
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    NSArray *constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    [self.view addConstraints:constraint_H];
    [self.view addConstraints:constraint_V];
}

- (void)refreshConetnt:(UIView *)sender{
    if ([self.dataSource respondsToSelector:@selector(imageBrowserViewControllerReloadData:)])
        [self.dataSource imageBrowserViewControllerReloadData:self];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource imageBrowserViewControllerNumberOfImages:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageBrowserTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ImageBrowserTableViewCellID];
    cell.imageInfo = nil;
    cell.imageInfo = [self.dataSource imageBrowserViewControllerInfoForImage:self atIndex:indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSArray *visibleCells = [self.tableView visibleCells];
//    for (ImageBrowserTableViewCell *cell in visibleCells){
//        [cell loadHiResolutionImage];
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IBImageViewerViewController *vc = [IBImageViewerViewController new];
    vc.imageInfo = [self.dataSource imageBrowserViewControllerInfoForImage:self atIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -IBImageBrowserDataSourceDelegate
-(void)imageBrowserDataSourceFinishLoadingData:(IBImageBrowserDataSource *) imageBrowserDataSource withError:(NSError *) error{
    [self.refreshControl endRefreshing];
    if (error)
        [self showError:error];
    else
        [self.tableView reloadData];
}

- (void)showError:(NSError *) error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}



@end
