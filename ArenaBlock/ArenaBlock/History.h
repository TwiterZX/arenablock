//
//  History.h
//  ArenaBlock
//
//  Created by Clement Yerochewski on 19/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HistoryMove;

@interface History : NSObject
{
    NSMutableArray *historyMoveArray;
    NSMutableArray *historyPieceArray;
    NSArray             *lastPiece;
    NSUInteger          id_gameCenter;
}

@property (nonatomic, strong)  NSMutableArray     *historyMoveArray;
@property (nonatomic, strong) NSMutableArray      *historyPieceArray;
@property (nonatomic, strong) NSArray             *lastPiece;
@property (nonatomic, assign) NSUInteger          id_gameCenter;

+ (History *)sharedInstance;


- (void)addMoveToHistory:(HistoryMove *)history;

- (void)addPieceToHistory:(NSMutableArray *)pieceDict forHost:(BOOL)isHost;
- (void)setLastPiece:(NSArray *)pieceArray forHost:(BOOL)isHost;

@end
