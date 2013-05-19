//
//  Player.h
//  ArenaBlock
//
//  Created by Salhi Yacine on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

@class MCSpriteLayer;
@class Player;

@protocol PlayerDataSourceProtocol <NSObject>

- (UIView *)viewForPlayer:(Player *)p;

@end

@interface Player : NSObject {
    NSInteger   idP;
    CGPoint position;
    
    NSMutableArray *_arrayPieces;
    MCSpriteLayer *_spritePlayer;
    
    id<PlayerDataSourceProtocol> delegateSprite;
}

- (id)initWithDelegate:(id<PlayerDataSourceProtocol>)del;
- (void)movePlayerWithPiece:(Piece *)p;

- (CGPoint)position;

@end
