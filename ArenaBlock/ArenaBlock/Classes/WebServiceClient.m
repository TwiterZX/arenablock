//
//  WebServiceClient.m
//
//  Created by Salhi Yacine on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Reachability.h"
#import "MBProgressHUD.h"
#import "WebServiceClient.h"
#import "NSObject+SBJson.h"
#import "ASIFormDataRequest.h"

@implementation WebServiceClient

@synthesize wsdelegate=_wsdelegate;

#pragma mark - Shared Instance

static WebServiceClient *_instance = nil;

+ (id)sharedInstance
{
    if (_instance == nil)
    {
        _instance = [[WebServiceClient alloc] init];
    }
    return _instance;
}

#pragma mark - Init

- (id)init
{
    self = [super init];
    if (self)
    {
        _isInternetAvailable = FALSE;
        _wsdelegate = nil;

        // We start notification for internet connection
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
        internetReachable = [Reachability reachabilityForInternetConnection];
        [internetReachable startNotifier];
        hostReachable = [Reachability reachabilityWithHostName:@"www.google.fr"];
        [hostReachable startNotifier];
        [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification object:nil];
     }
    return (self);
}

#pragma mark - Getter

- (BOOL)isInternetAvailable
{
    return _isInternetAvailable;
}

#pragma mark - Internet Connection

- (void)checkNetworkStatus:(NSNotification *)notice
{
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is inaccessible.");
            _isInternetAvailable = FALSE;
            break;
        }
            
        case ReachableViaWiFi:
        {
            NSLog(@"Internet Connection is UP.");
            _isInternetAvailable = TRUE;
            break;
        }
            
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            _isInternetAvailable = TRUE;
            break;
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            _isInternetAvailable = FALSE;
            break;
        }
            
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            _isInternetAvailable = TRUE;
            break;
        }
            
        case ReachableViaWWAN:
        {
            _isInternetAvailable = TRUE;
            NSLog(@"A gateway to the host server is working via WWAN.");
            break;
        }
    }
    
    // There is internet connection
    if (_isInternetAvailable == TRUE)
    {
        #warning - This is a test
        [self createGameWithPlayer1:43 player2:4343];
    }
}

#pragma mark - Create Game

- (void)createGameWithPlayer1:(NSInteger)p1 player2:(NSInteger)p2
{
    if (_isInternetAvailable == TRUE)
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/create", SERVER_HOST]];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setDelegate:self];
        [request setTimeOutSeconds:REQUEST_TIMEOUT];
        [request setDidFinishSelector:@selector(createGameSuccess:)];
        [request setDidFailSelector:@selector(createGameFailed:)];
        [request setPostValue:[NSNumber numberWithInt:p1] forKey:@"first_player"];
        [request setPostValue:[NSNumber numberWithInt:p2] forKey:@"second_player"];
        [request startAsynchronous];
    }
    else
    {
        if (_wsdelegate)
            [_wsdelegate createGameFailed:@"Vous n'avez pas de connexion internet. Vous ne pouvez jouer"];
    }
}

- (void)createGameSuccess:(ASIHTTPRequest *)request
{
    NSString *answer = [request responseString];
    NSInteger res = [answer intValue];

    DLog(@"res %@", answer);
    if (res == TRUE)
    {
        if (_wsdelegate)
            [_wsdelegate createGameSuccess:request];
    }
}

- (void)createGameFailed:(ASIHTTPRequest *)request
{
    if ([[request error] code] == REQUEST_TIMEOUT)
    {
        DLog(@"Request time out");
    }
    else
    {
        if (_wsdelegate)
            [_wsdelegate createGameFailed:@"Nous ne pouvons créer une session de jeu."];
    }
}

@end