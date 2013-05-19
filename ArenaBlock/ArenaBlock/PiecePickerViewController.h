//
//  PiecePickerViewController.h
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

@class Piece;
@class Player;

@protocol PiecePickerDelegateProtocol <NSObject>

- (void)piecePickerDelegatePlayerPlayedPiece:(Piece *)p;

- (CGPoint)fetchPlayer1Position;

@end

@interface PiecePickerViewController : UIViewController <UIGestureRecognizerDelegate>

@property CGFloat degrees_1;
@property CGFloat degrees_2;
@property CGFloat degrees_3;

@property (nonatomic, weak) IBOutlet UIImageView *pieceImg_1;
@property (nonatomic, weak) IBOutlet UIImageView *pieceImg_2;
@property (nonatomic, weak) IBOutlet UIImageView *pieceImg_3;
@property (nonatomic, strong) NSMutableArray *arrayOfPieces;
@property (nonatomic, assign) IBOutlet id<PiecePickerDelegateProtocol> delegatePicker;

@end
