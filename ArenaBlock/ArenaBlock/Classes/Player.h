//
//  Player.h
//  ArenaBlock
//
//  Created by Salhi Yacine on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject {
    NSInteger   idP;
    CGPoint position;
    NSMutableArray *_arrayPieces;
}

@end
