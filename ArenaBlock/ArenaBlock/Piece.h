//
//  Piece.h
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Piece : NSObject

@property(nonatomic, strong)    UIImage      *pieceImage;
@property(nonatomic, strong)    NSDictionary *pieceDict;
@property(nonatomic, assign)    NSUInteger   piecePos;

@end
