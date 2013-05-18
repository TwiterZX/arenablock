//
//  PieceGenerator.h
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PieceGenerator : NSObject {
    NSArray *_arrayPieces;
}

+ (PieceGenerator *)sharedInstance;

- (void)fillArray:(NSMutableArray **)array limit:(NSInteger)lim;
- (UIImage *)createPieceGenerator:(NSDictionary *)pieceCoordonates;

@end
