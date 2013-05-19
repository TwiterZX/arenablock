//
//  History.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 19/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "History.h"

@implementation History


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
        historyMove = [NSMutableArray array];
        historyPiece = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Method History Movement

- (void)addMoveToHistory:(NSMutableArray *)moveDict forHost:(BOOL)isHost
{
    
}

- (void)addPieceToHistory:(NSMutableArray *)pieceDict forHost:(BOOL)isHost
{
    
}


#pragma mark - Method Change Last Piece

- (void)setLastPiece:(NSArray *)pieceArray forHost:(BOOL)isHost {
    lastPiece = [[NSArray alloc] initWithArray:pieceArray];
}


@end
