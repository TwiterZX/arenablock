//
//  WebServiceProtocol.h
//
//  Created by Salhi Yacine on 14/05/12.
//  Copyright (c) 2012 Vivactis Multimedia. All rights reserved.
//

@class AssetData;
@class ASIHTTPRequest;

@protocol WebServiceProtocol <NSObject>

- (void)canNotAccessApplication:(NSString *)msg;

- (void)createGameSuccess:(ASIHTTPRequest *)request;
- (void)createGameFailed:(NSString *)answer;

@end