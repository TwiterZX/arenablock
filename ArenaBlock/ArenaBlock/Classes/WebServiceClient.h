//
//  WebServiceClient.h
//
//  Created by Salhi Yacine on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebServiceProtocol.h"

@class Reachability;

typedef enum WSCode
{
    WSCodeSuccess = 200,
    WSCodeNotAuthorized = 401
}   WSCode;

typedef void(^WebServiceCallback)(id argsData);

@interface WebServiceClient : NSObject
{
    Reachability *internetReachable;
    Reachability *hostReachable;

    BOOL    _isInternetAvailable; // If there is an internet connection
}

@property (nonatomic, assign) id<WebServiceProtocol>    wsdelegate;

+ (id)sharedInstance;

- (BOOL)isInternetAvailable;
- (void)createGame;
- (void)movePiece:(NSString *)pieceName;

@end
