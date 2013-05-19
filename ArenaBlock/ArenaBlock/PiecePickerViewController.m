//
//  PiecePickerViewController.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "PieceGenerator.h"
#import "Piece.h"
#import "MoveManager.h"
#import "AppDelegate.h"
#import "BoardViewController.h"
#import "PiecePickerViewController.h"



@interface PiecePickerViewController ()

@end

@implementation PiecePickerViewController

@synthesize pieceImg_1, pieceImg_2, pieceImg_3, arrayOfPieces;
@synthesize degrees_1, degrees_2, degrees_3;
@synthesize delegatePicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrayOfPieces = [NSMutableArray array];
    
    [[PieceGenerator sharedInstance] fillArray:arrayOfPieces limit:3];
    
    degrees_1 = 270;
    degrees_2 = 270;
    degrees_3 = 270;
    
    [self initPieces];
    [self initGesture];
    [self reloadViewPieces];
    
    for (UIViewController<PiecePickerDelegateProtocol> *vc in [[self parentViewController] childViewControllers]) {
        if ([vc isKindOfClass:[BoardViewController class]])
            self.delegatePicker = vc;
    }
}

- (void)initPieces
{
    pieceImg_1.userInteractionEnabled = YES;
    pieceImg_1.tag = 0;
    [pieceImg_1 setContentMode:UIViewContentModeScaleAspectFit];
    
    pieceImg_2.userInteractionEnabled = YES;
    pieceImg_2.tag = 1;
    [pieceImg_2 setContentMode:UIViewContentModeScaleAspectFit];
    
    [pieceImg_3 setContentMode:UIViewContentModeScaleAspectFit];
    pieceImg_3.userInteractionEnabled = YES;
    pieceImg_3.tag = 2;
}

- (void)initGesture
{
    UITapGestureRecognizer *tap_1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    UITapGestureRecognizer *tap_2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    UITapGestureRecognizer *tap_3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    
    UILongPressGestureRecognizer* longPressGesture_1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(playPiece:)];
    UILongPressGestureRecognizer* longPressGesture_2 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(playPiece:)];
    UILongPressGestureRecognizer* longPressGesture_3 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(playPiece:)];
    
    [pieceImg_1 addGestureRecognizer:longPressGesture_1];
    [pieceImg_2 addGestureRecognizer:longPressGesture_2];
    [pieceImg_3 addGestureRecognizer:longPressGesture_3];
    
    [tap_1 setNumberOfTapsRequired:1];
    [tap_1 setNumberOfTouchesRequired:1];
    [tap_2 setNumberOfTapsRequired:1];
    [tap_2 setNumberOfTouchesRequired:1];
    [tap_3 setNumberOfTapsRequired:1];
    [tap_3 setNumberOfTouchesRequired:1];
    
    [pieceImg_1 addGestureRecognizer:tap_1];
    [pieceImg_2 addGestureRecognizer:tap_2];
    [pieceImg_3 addGestureRecognizer:tap_3];
}


-(void)playPiece:(UISwipeGestureRecognizer *)gesture
{
    if(UIGestureRecognizerStateBegan == gesture.state) {
        NSInteger index = gesture.view.tag;
        Piece *p = (Piece *)[arrayOfPieces objectAtIndex:index];
        CGPoint playerPos = [delegatePicker fetchPlayer1Position];
        if ([MoveManager isMovePossible:p withPlayerPosition:playerPos]) {
            
            [[SoundManager sharedManager] playMusic:[appDelegate.bankOfSound valueForKey:@"Push"]  looping:NO];
            
            // Tells delegate the piece we have chosen
            if (delegatePicker)
                [delegatePicker piecePickerDelegatePlayerPlayedPiece:p];
            
            
            //  hMove.isHost = [delegatePicker fetchPlayer1Position]
            
            // Reload the pieces array
            [arrayOfPieces removeObjectAtIndex:index];
            [[PieceGenerator sharedInstance] fillArray:arrayOfPieces limit:3];
            [self reloadDegreeForIndex:index];
            [self reloadViewPieces];
        }
        else {
            
            [[SoundManager sharedManager] playMusic:[appDelegate.bankOfSound valueForKey:@"Wrong"]  looping:NO];
            UIAlertView *alert  =  [[UIAlertView alloc] initWithTitle:@"TU PEUX PAS JOUER CA MARCHE PAS BOUFON !" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }
}


- (void)reloadDegreeForIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [pieceImg_1 setNeedsDisplay];
            degrees_1 = 270;
            pieceImg_1.transform = CGAffineTransformIdentity;
            break;
            
        case 1:
            [pieceImg_2 setNeedsDisplay];
            degrees_2 = 270;
            pieceImg_2.transform = CGAffineTransformIdentity;
            break;
            
        case 2:
            degrees_3 = 270;
            [pieceImg_3 setNeedsDisplay];
            pieceImg_3.transform = CGAffineTransformIdentity;
            break;
            
        default:
            break;
    }
}

-(void)reloadViewPieces
{
    Piece *p1 = (Piece *)[arrayOfPieces objectAtIndex:0];
    Piece *p2 = (Piece *)[arrayOfPieces objectAtIndex:1];
    Piece *p3 = (Piece *)[arrayOfPieces objectAtIndex:2];
    
    [pieceImg_1 setImage:p1.pieceImage];
    [pieceImg_2 setImage:p2.pieceImage];
    [pieceImg_3 setImage:p3.pieceImage];
    
}

- (void)isPieceMovable:(Piece *)p forView:(UIImageView *)view
{
    //    NSLog(@"PIECE : %@", p);
    //    if ([MoveManager isMovePossible:p]) {
    //        [view setAlpha:1];
    //    }
    //    else {
    //        [view setAlpha:0.5];
    //    }
}

- (void)rotate:(UIGestureRecognizer *)sender
{
    NSInteger index = sender.view.tag;
    
    Piece *p = ((Piece *)[arrayOfPieces objectAtIndex:index]);
    
    
    [self setPositionOfPiece:p currentPos:p.piecePos];
    
    UIImageView *tmpImgView;
    
    switch (sender.view.tag) {
        case 0:
            pieceImg_1.transform = CGAffineTransformMakeRotation(degrees_1 * M_PI/180);
            tmpImgView = pieceImg_1;
            degrees_1 -= 90;
            break;
        case 1:
            pieceImg_2.transform = CGAffineTransformMakeRotation(degrees_2 * M_PI/180);
            tmpImgView = pieceImg_2;
            degrees_2 -= 90;
            break;
        case 2:
            pieceImg_3.transform = CGAffineTransformMakeRotation(degrees_3 * M_PI/180);
            tmpImgView = pieceImg_3;
            degrees_3 -= 90;
            break;
        default:
            break;
    }
    
    NSLog(@"degree : %i", degrees_1);
    
    [[SoundManager sharedManager] playMusic:[appDelegate.bankOfSound valueForKey:@"Rotate"]  looping:NO];

    [self isPieceMovable:p forView:tmpImgView];
}

- (void)setPositionOfPiece:(Piece *)p currentPos:(NSInteger)currentPos
{
    if (currentPos != 3) {
        [p setPiecePos:++currentPos];
    }
    else {
        [p setPiecePos:0];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
