//
//  BaseViewController.m
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/6/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

#import "BaseViewController.h"
#import <GoEuro-Swift.h>
#import <SDWebImage/UIImageView+WebCache.h>

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

- (NSInteger)timeDifference:(NSInteger)arrivalTime departureTime:(NSInteger)departureTime {
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:arrivalTime];
    NSDate* date2 = [NSDate dateWithTimeIntervalSince1970:departureTime];
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    double secondsInAnHour = 3600;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    
    return hoursBetweenDates;
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transportDetailModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GETransportModeCell *customCell = (GETransportModeCell*)[tableView dequeueReusableCellWithIdentifier:@"TransportModeCell" forIndexPath:indexPath];
    GETransportDetailModel *transportModel = [self.transportDetailModelArray objectAtIndex:indexPath.row];
    customCell.timeLabel.text = [NSString stringWithFormat:@"%@ - %@",transportModel.arrivalTime,transportModel.departureTime];
    customCell.priceLabel.text = [NSString stringWithFormat:@"%ld",(long)transportModel.priceInEuros];
    if (transportModel.numberOfStops > 0) {
        customCell.numberOfStopsLabel.text = [NSString stringWithFormat:@"%ld Change",(long)transportModel.numberOfStops];
    }
    else {
        customCell.numberOfStopsLabel.text = @"Direct";
    }
    
//    customCell.timeIntervalLabel.text = [self timeDifference:transportModel.arrivalTime departureTime:transportModel.departureTime];
    
    NSString *imageUrlString = transportModel.providerLogo;
    
    if ([imageUrlString containsString:@"{size}"]) {
        imageUrlString = [imageUrlString stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
        imageUrlString = [imageUrlString stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    }
    
    [customCell.logoImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    return customCell;
    
}
@end
