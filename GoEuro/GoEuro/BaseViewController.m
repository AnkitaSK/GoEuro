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

    self.transportDetailModelArray = [[NSMutableArray alloc] init];
    [self trainTransportDetails];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewWithData:) name:@"ReloadListView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadBySorting:) name:@"ReloadBySorting" object:nil];
}

- (void)reloadTableViewWithData:(NSNotification *)notification {
    NSDictionary *object = notification.object;
    [self.transportDetailModelArray removeAllObjects];
    
    NSNumber *typeAsNumber = [object objectForKey:@"transportType"];
    
    switch (typeAsNumber.intValue) {
        case 0:
            [self busTransportDetails];
            break;
        case 1:
            [self trainTransportDetails];
            break;
        case 2:
            [self flightTransportDetails];
            break;
            
        default:
            break;
    }
}

- (void)reloadBySorting:(NSNotification *)notification {
    NSDictionary *object = notification.object;
    NSString *keyValue = [object objectForKey:@"sortByKey"];
    
    [self reloadListDataBySortingWithKey:keyValue];
}

- (NSInteger)timeDifference:(NSInteger)arrivalTime departureTime:(NSInteger)departureTime {
    NSDate* date1 = [NSDate dateWithTimeIntervalSince1970:arrivalTime];
    NSDate* date2 = [NSDate dateWithTimeIntervalSince1970:departureTime];
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    double secondsInAnHour = 3600;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    
    return hoursBetweenDates;
}

- (void)busTransportDetails {
    NSArray *transportDetailsArray = [[GECacheManager sharedManager]objectForKey:@"BusData"];
    if (transportDetailsArray.count > 0) {
        [self.transportDetailModelArray addObjectsFromArray:transportDetailsArray];
        [self reloadListDataBySortingWithKey:@"departureTime"];
    }
    else {
        [[GETransportManager sharedManager] getBusTransportModeDetails:^(BOOL success) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.transportDetailModelArray addObjectsFromArray:[GETransportManager sharedManager].busTransportDetails];
                    [self reloadListDataBySortingWithKey:@"departureTime"];
                });
            }
        }];
    }
}

- (void)trainTransportDetails {
    NSArray *transportDetailsArray = [[GECacheManager sharedManager]objectForKey:@"TrainData"];
    if (transportDetailsArray.count > 0) {
        [self.transportDetailModelArray addObjectsFromArray:transportDetailsArray];
        [self reloadListDataBySortingWithKey:@"departureTime"];
    }
    else {
        [[GETransportManager sharedManager] getTrainTransportModeDetails:^(BOOL success) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.transportDetailModelArray addObjectsFromArray:[GETransportManager sharedManager].trainTransportDetails];
                    [self reloadListDataBySortingWithKey:@"departureTime"];
                });
            }
        }];
    }
}

- (void)flightTransportDetails {
    NSArray *transportDetailsArray = [[GECacheManager sharedManager]objectForKey:@"FlightData"];
    if (transportDetailsArray.count > 0) {
        [self.transportDetailModelArray addObjectsFromArray:transportDetailsArray];
        [self reloadListDataBySortingWithKey:@"departureTime"];
    }
    else {
        [[GETransportManager sharedManager] getFlightTransportModeDetails:^(BOOL success) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.transportDetailModelArray addObjectsFromArray:[GETransportManager sharedManager].flightTransportDetails];
                    [self reloadListDataBySortingWithKey:@"departureTime"];
                });
            }
        }];
    }
}

- (void)reloadListDataBySortingWithKey:(NSString *)key {
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:TRUE comparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSArray *sortedData = [self.transportDetailModelArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    [self.transportDetailModelArray addObjectsFromArray:sortedData];
    [self.listTableView reloadData];
}


#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transportDetailModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GETransportModeCell *customCell = (GETransportModeCell*)[tableView dequeueReusableCellWithIdentifier:@"TransportModeCell" forIndexPath:indexPath];
    GETransportDetailModel *transportModel = [self.transportDetailModelArray objectAtIndex:indexPath.row];
    customCell.timeLabel.text = [NSString stringWithFormat:@"%@ - %@",transportModel.departureTime,transportModel.arrivalTime];
    customCell.priceLabel.text = [NSString stringWithFormat:@"%ld",(long)transportModel.priceInEuros];
    customCell.timeIntervalLabel.text = [NSString stringWithFormat:@"%@h",transportModel.duration];
    if (transportModel.numberOfStops > 0) {
        customCell.numberOfStopsLabel.text = [NSString stringWithFormat:@"%ld Change",(long)transportModel.numberOfStops];
    }
    else {
        customCell.numberOfStopsLabel.text = @"Direct";
    }
    
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
