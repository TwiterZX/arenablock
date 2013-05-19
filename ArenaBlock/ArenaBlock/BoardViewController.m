//
//  BoardViewController.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "Piece.h"
#import "BoardViewController.h"

@interface BoardViewController ()

@end

@implementation BoardViewController

#define BOARD_WIDTH    4
#define BOARD_HEIGHT   4

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gridView.gridDelegate = self;
    
    // Init player
    player1 = [[Player alloc] initWithDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Piece Picker Delegate

- (void)piecePickerDelegatePlayerPlayedPiece:(Piece *)p {
    // Move player
    [player1 movePlayerWithPiece:p];
}

#pragma mark - ADBGridViewDelegate

- (NSString *)imagePathForADBGridView:(ADBGridView *)view atIndex:(NSUInteger)index
{
    return [[NSBundle mainBundle] pathForResource:@"piece" ofType:@"png"];
}

- (NSUInteger)numberOfImagesInGrid:(ADBGridView *)view
{
    return BOARD_HEIGHT * BOARD_HEIGHT;
}

- (NSUInteger)numberOfImagesForRow:(ADBGridView *)view
{
    return BOARD_WIDTH;
}

- (void)imageInADBGridView:(ADBGridView *)gridView singleTapImageView:(ADBImageView *)imageView
{
    DLog(@"Single tap on image");
}

- (void)imageInADBGridView:(ADBGridView *)gridView longPressImageView:(ADBImageView *)imageView
{
    DLog(@"Long press on image");
}

#pragma mark - Sprite Layer Protocol

- (UIView *)viewForPlayer:(Player *)p {
    return self.view;
}

- (CGPoint)fetchPlayer1Position {
    return [player1 position];
}

@end
