//
//  MoveManager.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "MoveManager.h"
#import "Piece.h"

@implementation MoveManager

+ (BOOL)isMovePossible:(Piece *)p withPlayerPosition:(CGPoint)playerPosition
{
    CGPoint departurePos = CGPointFromString([[[p.pieceDict valueForKey:@"pieces"] objectAtIndex:p.piecePos] objectAtIndex:0]);
    NSInteger arrival = [[[p.pieceDict valueForKey:@"pieces"] objectAtIndex:p.piecePos] count];
                         
    CGPoint arrivalPos = CGPointFromString([[[p.pieceDict valueForKey:@"pieces"] objectAtIndex:p.piecePos] objectAtIndex:arrival-1]);

    CGPoint newPos = CGPointMake(playerPosition.x - departurePos.x, playerPosition.y - departurePos.y);
    newPos = CGPointMake(newPos.x + arrivalPos.x, newPos.y + arrivalPos.y);
    
    if (newPos.x < 0 || newPos.x >= 4 || newPos.y < 0 || newPos.y >= 4)
    {
        return NO;
    }
    return YES;
}

+ (NSArray *)getPathAccordingToPiece:(NSArray *)coordinate andPlayerPosition:(CGPoint)playerPos
{
    CGPoint playerPosition = playerPos;
    NSMutableArray *arraOfCoor = [NSMutableArray array];

    CGPoint departurePos = CGPointFromString([coordinate objectAtIndex:0]);
    
    for (NSString *coordinateStr in coordinate) {
        
        DLog(@"Coordinate str %@ ", coordinateStr)
        CGPoint arrivalPos = CGPointFromString(coordinateStr);
        
        CGPoint newPos = CGPointMake(playerPosition.x - departurePos.x, playerPosition.y - departurePos.y);
        
        newPos = CGPointMake(newPos.x + arrivalPos.x, newPos.y + arrivalPos.y);
        [arraOfCoor addObject:NSStringFromCGPoint(newPos)];
    }
    return arraOfCoor;
}

@end
