//
//  Player.h
//  ArenaBlock
//
//  Created by Salhi Yacine on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

@class MCSpriteLayer;
@class Player;
@class Piece;

@protocol PlayerDataSourceProtocol <NSObject>

- (UIView *)viewForPlayer:(Player *)p;

@end

@interface Player : NSObject {
    CGPoint position;
    BOOL isHost;

    NSMutableArray *_arrayPieces;
    MCSpriteLayer *_spritePlayer;
    
    id<PlayerDataSourceProtocol> delegateSprite;
}

@property (nonatomic, assign) NSInteger   idP;

- (id)initWithHost:(BOOL)iH;
- (void)initSpriteWithDelegate:(id<PlayerDataSourceProtocol>)del;
- (void)movePlayerWithPiece:(Piece *)p;

- (CGPoint)position;

- (BOOL)isHost;
@end
