//
//  BoardViewController.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "Piece.h"
#import "BoardViewController.h"
#import "GameManager.h"
#import "PieceGenerator.h"

@interface BoardViewController ()

@end

@implementation BoardViewController

#define BOARD_WIDTH    4
#define BOARD_HEIGHT   4

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gridView.gridDelegate = self;
    
    [[[GameManager sharedInstance] fetchPlayerHost] initSpriteWithDelegate:self];
    [[[GameManager sharedInstance] fetchPlayerNotHost] initSpriteWithDelegate:self];
    
    [[WebServiceClient sharedInstance] setWsdelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebService Protocol

- (void)moveFromOtherPlayer:(NSDictionary *)dic {
    Player *slave = [[GameManager sharedInstance] fetchPlayerNotHost];
    
    Piece *p = [[PieceGenerator sharedInstance] getPieceFromString:[dic objectForKey:@"parameter"]];
    
    DLog(@"Dico %@", p.pieceDict);
    
    [slave movePlayerWithPiece:p];
}

#pragma mark - Piece Picker Delegate

- (void)piecePickerDelegatePlayerPlayedPiece:(Piece *)p {
    Player *host = [[GameManager sharedInstance] fetchPlayerHost];
    Player *slave = [[GameManager sharedInstance] fetchPlayerNotHost];
    
    // Move player
    [host movePlayerWithPiece:p];

    // Send Move to Server
    [[WebServiceClient sharedInstance] movePiece:[NSString stringWithFormat:@"%@%i", [p.pieceDict objectForKey:@"name"], p.piecePos]];
    
#warning - Disable Picker 
    
    // Test if player 1 won
    if ([NSStringFromCGPoint(host.position) isEqualToString:NSStringFromCGPoint(slave.position)]) {
        DLog(@"Le HOST a gagne");

#warning - WebService - tell server message WIN
        // Afficher WIN VIEW
    }
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
    return [[[GameManager sharedInstance] fetchPlayerHost] position];
}

@end
