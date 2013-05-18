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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    NSMutableArray *arrayP = [NSMutableArray array];
    [[PieceGenerator sharedInstance] fillArray:&arrayP limit:3];
    
    NSLog(@"arrayP : %@", arrayP);
    
    UIButton *piece_0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [piece_0 addTarget:self
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchDown];
    [piece_0 setTitle:@"Show View" forState:UIControlStateNormal];
    [piece_0 setBackgroundImage:((Piece *)[arrayP objectAtIndex:0]).pieceImage forState:UIControlStateNormal];
    piece_0.tag = 1;

    [[piece_0 imageView] setContentMode: UIViewContentModeScaleAspectFit];

    piece_0.frame = CGRectMake(0, 0, 50, 50);
    [self.view addSubview:piece_0];
    
    UIButton *piece_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [piece_1 addTarget:self
                action:@selector(aMethod:)
      forControlEvents:UIControlEventTouchDown];
    [piece_1 setContentMode:UIViewContentModeScaleAspectFit];
    piece_1.tag = 1;
    [piece_1 setBackgroundImage:((Piece *)[arrayP objectAtIndex:1]).pieceImage forState:UIControlStateNormal];

    [piece_1 setTitle:@"Show View" forState:UIControlStateNormal];
    piece_1.frame = CGRectMake(60, 0, 50, 50);
    [self.view addSubview:piece_1];
    
    UIButton *piece_2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [piece_2 addTarget:self
                action:@selector(aMethod:)
      forControlEvents:UIControlEventTouchDown];
    [piece_2 setContentMode:UIViewContentModeScaleAspectFit];
    [piece_2 setTitle:@"Show View" forState:UIControlStateNormal];
    [piece_2 setBackgroundImage:((Piece *)[arrayP objectAtIndex:2]).pieceImage forState:UIControlStateNormal];
    piece_2.frame = CGRectMake(120, 0, 50, 50);
    piece_2.tag = 2;

    [self.view addSubview:piece_2];
    
	// Do any additional setup after loading the view.
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
