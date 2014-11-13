//
//  NetStatus.m
//  JiaKe
//
//  Created by hgs泽泓 on 14/10/20.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "NetStatus.h"
#import "Reachability.h"

@interface NetStatus()

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;

@end

@implementation NetStatus
-(void)getNetStatus
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    //Change the host name here to change the server you want to monitor.
    //连接都服务器
    NSString *remoteHostName = @"121.40.92.53";
//    NSString *remoteHostLabelFormatString = NSLocalizedString(@"Remote Host: %@", @"Remote host label format string");
//    self.remoteHostLabel.text = [NSString stringWithFormat:remoteHostLabelFormatString, remoteHostName];
    
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
    
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
    [self updateInterfaceWithReachability:self.wifiReachability];
}
- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
    {
//        [self configureTextField:self.remoteHostStatusField imageView:self.remoteHostImageView reachability:reachability];
//        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL connectionRequired = [reachability connectionRequired];
        
//        self.summaryLabel.hidden = (netStatus != ReachableViaWWAN);
//        NSString* baseLabelText = @"";
        
        if (connectionRequired)
        {
//            baseLabelText = NSLocalizedString(@"Cellular data network is available.\nInternet traffic will be routed through it after a connection is established.", @"Reachability text if a connection is required");
            NSLog(@"发送请求~");
        }
        else
        {
//            baseLabelText = NSLocalizedString(@"Cellular data network is active.\nInternet traffic will be routed through it.", @"Reachability text if a connection is not required");
        }
//        self.summaryLabel.text = baseLabelText;
    }
    
    if (reachability == self.internetReachability)
    {
//        [self configureTextField:self.internetConnectionStatusField imageView:self.internetConnectionImageView reachability:reachability];
        NSLog(@"2G/3G/4G");
    }
    
    if (reachability == self.wifiReachability)
    {
//        [self configureTextField:self.localWiFiConnectionStatusField imageView:self.localWiFiConnectionImageView reachability:reachability];
        NSLog(@"wifi");
    }
}

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}
@end
