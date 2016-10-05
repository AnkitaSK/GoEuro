//
//  BaseViewController.m
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/6/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

#import "BaseViewController.h"
@class GETransportDetailListViewController;
@class GETransportModeCell;
@class GETransportDetailModel;

@interface BaseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *transportDetailModelArray;
@end

@implementation BaseViewController

-(void) viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewWithData:) name:@"ReloadListView" object:nil];
}

- (void)reloadTableViewWithData:(NSNotification *)notification {
    NSDictionary *object = notification.object;
    
    self.transportDetailModelArray = [[NSMutableArray alloc] init];
    [self.transportDetailModelArray addObjectsFromArray:[object objectForKey:@"transportDetails"]];
    [self.listTableView reloadData];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transportDetailModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GETransportModeCell *customCell = (GETransportModeCell*)[tableView dequeueReusableCellWithIdentifier:@"TransportModeCell" forIndexPath:indexPath];
    GETransportDetailModel *transportModel = [self.transportDetailModelArray objectAtIndex:indexPath.row];
//    customCell.timeLabel.text = transportModel.departureTime;
    
    return customCell;
    
}
@end
