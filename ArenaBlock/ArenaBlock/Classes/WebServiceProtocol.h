//
//  WebServiceProtocol.h
//
//  Created by Salhi Yacine on 14/05/12.
//  Copyright (c) 2012 Vivactis Multimedia. All rights reserved.
//

@class AssetData;
@class ASIHTTPRequest;

@protocol WebServiceProtocol <NSObject>

- (void)createGameSuccess:(ASIHTTPRequest *)request;
- (void)createGameFailed:(NSString *)answer;

- (void)joinedGameSuccess:(NSDictionary *)dic;
- (void)moveFromOtherPlayer:(NSDictionary *)dic;

@end