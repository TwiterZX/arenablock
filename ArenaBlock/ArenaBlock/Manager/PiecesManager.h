//
//  PiecesManager.h
//  ArenaBlock
//
//  Created by Salhi Yacine on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

@interface PiecesManager : NSObject {
    NSArray *_arrayPieces;
}

+ (PiecesManager *)sharedInstance;

- (void)fillArray:(NSMutableArray **)array limit:(NSInteger)lim;

@end
