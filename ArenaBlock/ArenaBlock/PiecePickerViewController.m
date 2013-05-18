//
//  PiecePickerViewController.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "PiecePickerViewController.h"
#import "PieceGenerator.h"
#import "Piece.h"

@interface PiecePickerViewController ()

@end

@implementation PiecePickerViewController

@synthesize pieceImg_1, pieceImg_2, pieceImg_3, arrayOfPieces;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.view setBackgroundColor:[UIColor greenColor]];
    
    arrayOfPieces = [NSMutableArray array];
    
    [[PieceGenerator sharedInstance] fillArray:arrayOfPieces limit:3];
    
//    arrayOfPieces = [[NSMutableArray alloc] initWithArray:arrayP];

    
  // pieceImg_1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 140, 140)];
    pieceImg_1.userInteractionEnabled = YES;
    pieceImg_1.tag = 0;
    [pieceImg_1 setContentMode:UIViewContentModeScaleAspectFit];
    
    
   // pieceImg_2 = [[UIImageView alloc] initWithFrame:CGRectMake(180, 0, 140, 140)];
    pieceImg_2.userInteractionEnabled = YES;
    pieceImg_2.tag = 1;
    [pieceImg_2 setContentMode:UIViewContentModeScaleAspectFit];

    
   // pieceImg_3 = [[UIImageView alloc] initWithFrame:CGRectMake(340, 0, 140, 140)];
    [pieceImg_3 setContentMode:UIViewContentModeScaleAspectFit];
    pieceImg_3.userInteractionEnabled = YES;
    pieceImg_3.tag = 2;

    [pieceImg_1 setImage:((Piece *)[arrayOfPieces objectAtIndex:0]).pieceImage];
    [pieceImg_2 setImage:((Piece *)[arrayOfPieces objectAtIndex:1]).pieceImage];
    [pieceImg_3 setImage:((Piece *)[arrayOfPieces objectAtIndex:2]).pieceImage];

    [self.view addSubview:pieceImg_1];
    [self.view addSubview:pieceImg_2];
    [self.view addSubview:pieceImg_3];
    
    
    UITapGestureRecognizer *tap_1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
//    UITapGestureRecognizer *tap_11 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(play:)];

    UITapGestureRecognizer *tap_2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];

    UITapGestureRecognizer *tap_3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];

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

- (void)play:(UIGestureRecognizer *)sender
{
    NSInteger index = sender.view.tag;
    Piece *p = ((Piece *)[arrayOfPieces objectAtIndex:index]);
    
    
}

- (void)rotate:(UIGestureRecognizer *)sender
{
    NSInteger index = sender.view.tag;
    
    Piece *p = ((Piece *)[arrayOfPieces objectAtIndex:index]);
    
    [self setPositionOfPiece:p currentPos:p.piecePos];
    
    static    float degrees = 90; 

    switch (sender.view.tag) {
        case 0:
            pieceImg_1.transform = CGAffineTransformMakeRotation(degrees * M_PI/180);
            break;
        case 1:
            pieceImg_2.transform = CGAffineTransformMakeRotation(degrees * M_PI/180);
            break;
        case 2:
            pieceImg_3.transform = CGAffineTransformMakeRotation(degrees * M_PI/180);
            break;
        default:
            break;
    }
    
    degrees += 90;
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

-(void)handleTap
{
    
//    [(UIGestureRecognizer *)sender view].tag

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
