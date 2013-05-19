//
//  History.h
//  ArenaBlock
//
//  Created by Clement Yerochewski on 19/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject
{
    NSMutableArray *historyMove;
    NSMutableArray *historyPiece;
    NSArray             *lastPiece;
    NSUInteger          id_gameCenter;
}

+ (History *)sharedInstance;

@end
