//
//  History.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 19/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "History.h"
#import "HistoryMove.h"

@implementation History

@synthesize historyMoveArray, historyPieceArray, lastPiece, id_gameCenter;

static  History *_instance = nil;

#pragma mark - Shared instance

+ (History *)sharedInstance {
    if (!_instance) {
        _instance = [[self alloc ] init];
    }
    return _instance;
}

#pragma mark - Init 

- (id)init {
    self = [super init];
    if (self) {
        historyMoveArray = [NSMutableArray array];
        historyPieceArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Method History Movement

- (void)addMoveToHistory:(HistoryMove *)history
{
    [self.historyMoveArray addObject:history];
}


- (void)addPieceToHistory:(NSMutableArray *)pieceDict forHost:(BOOL)isHost
{
    
}


#pragma mark - Method Change Last Piece

- (void)setLastPiece:(NSArray *)pieceArray forHost:(BOOL)isHost {
    lastPiece = [[NSArray alloc] initWithArray:pieceArray];
}


@end
