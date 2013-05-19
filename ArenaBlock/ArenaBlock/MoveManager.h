//
//  MoveManager.h
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import <Foundation/Foundation.h>



@class Piece;

@interface MoveManager : NSObject


+ (BOOL)isMovePossible:(Piece *)p withPlayerPosition:(CGPoint)playerPosition;
+ (NSArray *)getPathAccordingToPiece:(NSArray *)coordinate andPlayerPosition:(CGPoint)playerPos;

@end
