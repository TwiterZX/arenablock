//
//  WebServiceClient.m
//
//  Created by Salhi Yacine on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "WebServiceClient.h"
#import "NSObject+SBJson.h"
#import "ASIFormDataRequest.h"
#import "Player.h"

@implementation WebServiceClient

#define TIMEOUT_PULLING 5.0

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
}

#pragma mark - Create Game

- (void)createGame
{
    if (_isInternetAvailable == TRUE)
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/smart_create", SERVER_HOST]];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setDelegate:self];
        [request setTimeOutSeconds:REQUEST_TIMEOUT];
        [request setDidFinishSelector:@selector(createGameSuccess:)];
        [request setDidFailSelector:@selector(createGameFailed:)];
        [request startAsynchronous];
    }
    else
    {
        if (_wsdelegate)
            [_wsdelegate createGameFailed:@"No internet access."];
    }
}

- (void)createGameSuccess:(ASIHTTPRequest *)request
{
    if (_wsdelegate)
        [_wsdelegate createGameSuccess:request];

    // Start NSTimer
    [NSTimer scheduledTimerWithTimeInterval:TIMEOUT_PULLING target:self selector:@selector(checkForNewStatus) userInfo:nil repeats:YES];
}

- (void)createGameFailed:(ASIHTTPRequest *)request
{
    if ([[request error] code] == REQUEST_TIMEOUT)
    {
        // We reload the create game
        [self createGame];
    }
    else
    {
        if (_wsdelegate)
            [_wsdelegate createGameFailed:@"Sorry. Cant contact server"];
    }
}

#pragma mark - Pulling

- (void)checkForNewStatus {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/app_state", SERVER_HOST]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request setDelegate:self];
    [request setPostValue:(([[[GameManager sharedInstance] player1] isHost]) ? (@"true") : (@"false")) forKey:@"is_host"];
    [request setPostValue:[NSNumber numberWithInteger:[[GameManager sharedInstance] idGame]] forKey:@"game"];
    [request setTimeOutSeconds:REQUEST_TIMEOUT];
    [request setDidFinishSelector:@selector(checkStatusSuccess:)];
    [request setDidFailSelector:@selector(checkStatusFailed:)];
    [request startAsynchronous];
}

- (void)checkStatusSuccess:(ASIHTTPRequest *)request
{
    DLog(@"Response string %@", [request responseString]);
    if (![[request responseString] isEqualToString:@"false"]) {
        NSDictionary *dic = [[request responseString] JSONValue];
        if ([[dic objectForKey:@"function"] isEqualToString:@"game_joined"]) {
            if (_wsdelegate)
                [_wsdelegate joinedGameSuccess:dic];
        }
        else if ([[dic objectForKey:@"function"] isEqualToString:@"move"]) {
            if (_wsdelegate)
                [_wsdelegate moveFromOtherPlayer:dic];
        }
    }
}

- (void)checkStatusFailed:(ASIHTTPRequest *)request
{
    if ([[request error] code] == REQUEST_TIMEOUT)
    {
        [self checkForNewStatus];
    }
    else
    {
//        if (_wsdelegate)
//            [_wsdelegate createGameFailed:@"Sorry. Cant contact server"];
    }
}

#pragma mark - Move 

- (void)movePiece:(NSString *)pieceName {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/move", SERVER_HOST]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request setDelegate:self];
    [request setPostValue:(([[[GameManager sharedInstance] player1] isHost]) ? (@"true") : (@"false")) forKey:@"is_host"];
    [request setPostValue:[NSNumber numberWithInteger:[[GameManager sharedInstance] idGame]] forKey:@"game"];
    [request setPostValue:pieceName forKey:@"piece"];
    [request setTimeOutSeconds:REQUEST_TIMEOUT];
    [request setDidFinishSelector:@selector(movePieceSuccess:)];
    [request setDidFailSelector:@selector(movePieceFailed:)];
    [request startAsynchronous];
}

- (void)movePieceSuccess:(ASIHTTPRequest *)request
{
    DLog(@"Response string %@", [request responseString]);
    if (![[request responseString] isEqualToString:@"false"]) {
        NSDictionary *dic = [[request responseString] JSONValue];
        if ([[dic objectForKey:@"function"] isEqualToString:@"game_joined"]) {
            if (_wsdelegate)
                [_wsdelegate joinedGameSuccess:dic];
        }
    }
}

- (void)movePieceFailed:(ASIHTTPRequest *)request
{
    if ([[request error] code] == REQUEST_TIMEOUT)
    {
    }
    else
    {
        //        if (_wsdelegate)
        //            [_wsdelegate createGameFailed:@"Sorry. Cant contact server"];
    }
}

@end