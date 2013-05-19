//
//  PiecePickerViewController.h
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundManager.h"

@class Piece;
@class Player;

@protocol PiecePickerDelegateProtocol <NSObject>

- (void)piecePickerDelegatePlayerPlayedPiece:(Piece *)p;

- (CGPoint)fetchPlayer1Position;

@end

@interface PiecePickerViewController : UIViewController <UIGestureRecognizerDelegate>

@property int degrees_1;
@property int degrees_2;
@property int degrees_3;


@property (nonatomic, weak) IBOutlet UIImageView *pieceImg_1;
@property (nonatomic, weak) IBOutlet UIImageView *pieceImg_2;
@property (nonatomic, weak) IBOutlet UIImageView *pieceImg_3;
@property (nonatomic, strong) NSMutableArray *arrayOfPieces;
@property (nonatomic, assign) IBOutlet id<PiecePickerDelegateProtocol> delegatePicker;

@end
