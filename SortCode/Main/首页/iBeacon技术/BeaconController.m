//
//  BeaconController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/1/3.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "BeaconController.h"
#import <CoreLocation/CoreLocation.h> 
#define BEACONUUID @"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"//iBeacon的uuid可以换成自己设备的uuid
#define MY_REGION_IDENTIFIER @"my region"
@interface BeaconController ()<CLLocationManagerDelegate>
{
    //Used for get iBeacon signal
    CLLocationManager *_locationManager;    //
    CLBeaconRegion *_region;            //
    NSArray *_detectedBeacons;          //存放接收到的beacons
}

@end


@implementation BeaconController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"微定位服务";
    [self turnOnBeacon];
    
}


#pragma mark - Beacons Methods
- (void) turnOnBeacon{
    [self initLocationManager];
    [self initBeaconRegion];
    //[self initDetectedBeaconsList];
    [self startBeaconRanging];
}





#pragma mark Init Beacons
- (void) initLocationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [self checkLocationAccessForRanging];
    }
}

//- (void) initDetectedBeaconsList{
//    if (!_detectedBeacons) {
//        _detectedBeacons = [[NSArray array] init];
//    }
//}


- (void) initBeaconRegion{
    if (_region)
        return;
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:BEACONUUID];
    
    _region = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:MY_REGION_IDENTIFIER];
    _region.notifyEntryStateOnDisplay = YES;
    
}


#pragma mark Beacons Ranging

- (void) startBeaconRanging{
    
    if (!_locationManager || !_region) {
        return;
    }
    
    if (_locationManager.rangedRegions.count > 0) {
        
        NSLog(@"Didn't turn on ranging: Ranging already on.");
        
        return;
    }
    
    
    [_locationManager startRangingBeaconsInRegion:_region];
    
}



- (void) stopBeaconRanging{
    
    if (!_locationManager || !_region) {
        return;
    }
    
    [_locationManager stopRangingBeaconsInRegion:_region];
}




- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    
    NSLog(@"%@",[region.proximityUUID UUIDString]);
    
    NSLog(@"%@",BEACONUUID);
    
    
    //如果存在不是我们要监测的iBeacon那就停止扫描他
    
    if (![[region.proximityUUID UUIDString] isEqualToString:BEACONUUID]){
        
        [_locationManager stopMonitoringForRegion:region];
        
        [_locationManager stopRangingBeaconsInRegion:region];
        
    }
    
    
    if (beacons.count == 0) {
        
        NSLog(@"No beacons found nearby.");
        
        
    } else {
        //_detectedBeacons = beacons;
        NSLog(@"beacons count:%lu", beacons.count);
        
        for (CLBeacon *beacon in beacons) {
            NSLog(@"%@", [self detailsStringForBeacon:beacon]);
        }
    }
}




#pragma mark Process Beacon Information
//将beacon的信息转换为NSString并返回
- (NSString *)detailsStringForBeacon:(CLBeacon *)beacon
{
    
    NSString *format = @"%@ • %@ • %@ • %f • %li";
    return [NSString stringWithFormat:format, beacon.major, beacon.minor, [self stringForProximity:beacon.proximity], beacon.accuracy, beacon.rssi];
}



- (NSString *)stringForProximity:(CLProximity)proximity{
    NSString *proximityValue;
    switch (proximity) {
        case CLProximityNear:
            proximityValue = @"Near";
            break;
        case CLProximityImmediate:
            proximityValue = @"Immediate";
            break;
        case CLProximityFar:
            proximityValue = @"Far";
            break;
        case CLProximityUnknown:
        default:
            proximityValue = @"Unknown";
            break;
    }
    
    return proximityValue;
}



- (void)checkLocationAccessForRanging {
    
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
}



-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
   // _region.notifyOnEntry=NO;
    
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
