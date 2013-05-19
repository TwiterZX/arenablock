//
//  Player.m
//  ArenaBlock
//
//  Created by Salhi Yacine on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "MoveManager.h"
#import "Piece.h"
#import "MCSpriteLayer.h"
#import "Player.h"
#import "WebServiceClient.h"

#import "HistoryMove.h"
#import "History.h"

@implementation Player

@synthesize  idP;

#define SIZE_CUBE   80  // half of a case
#define WIDTH_SPRITE    80.0
#define HEIGHT_SPRITE   80.0
#define REPEAT_ANIMATION    2.0

#define TIMER_ANIMATION     5.0

#define PLAYER1_POS CGPointMake(0, 0)
#define PLAYER2_POS CGPointMake(3, 3)

#pragma mark - Init player

- (id)initWithHost:(BOOL)iH {
    self = [super init];
    if (self) {
        isHost = iH;
    }
    return self;
}

#pragma mark - Init sprite

- (void)initSpriteWithDelegate:(id<PlayerDataSourceProtocol>)del {
    delegateSprite = del;
    
    // Sprite
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sprite_idle" ofType:@"png"];
    CGImageRef richterImg = [UIImage imageWithContentsOfFile:path].CGImage;
    CGSize fixedSize = CGSizeMake(WIDTH_SPRITE, HEIGHT_SPRITE);
    _spritePlayer = [MCSpriteLayer layerWithImage:richterImg sampleSize:fixedSize];

    if (isHost) {
        _spritePlayer.position = [self moveToCoordinate:PLAYER1_POS];
        position = PLAYER1_POS;
    } else {
        _spritePlayer.position = [self moveToCoordinate:PLAYER2_POS];
        position = PLAYER2_POS;
    }

    [self setUpAnimation];
    
    UIView *v = [delegateSprite viewForPlayer:self];
    [v.layer addSublayer:_spritePlayer];
}

#pragma mark - Getter

- (CGPoint)position {
    return position;
}

- (BOOL)isHost {
    return isHost;
}

#pragma mark - Move player

- (void)movePlayerWithPiece:(Piece *)p {
    // Generate animation
    NSArray *pp = [[p.pieceDict objectForKey:@"pieces"] objectAtIndex:p.piecePos];
    NSArray *ppConverted = [MoveManager getPathAccordingToPiece:pp andPlayerPosition:position];
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *arrayMovement = [NSMutableArray array];

    for (int i = 0, end = [ppConverted count]; i < end; i++) {
        NSString *s = [ppConverted objectAtIndex:i];
        [array addObject:[self animateMovePlayerToPoint:CGPointFromString(s)]];
        [arrayMovement addObject:s];
    }

    // Animate whole group
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.5 * [array count];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    group.animations = array;

    [_spritePlayer addAnimation:group forKey:@"allMyAnimations"];
    
    DLog(@"End move %@", NSStringFromCGPoint(_spritePlayer.position));
        
    // record movement
    HistoryMove *hMove = [[HistoryMove alloc] init];
    
    DLog(@"move : %@", [[p.pieceDict objectForKey:@"pieces"] objectAtIndex:p.piecePos]);
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"move", arrayMovement,  nil];
    
    [hMove setIsHost:self.isHost];
    [hMove setMoveDictionnary:dictionnary];
    
    DLog(@"dictionnary of move : %@", dictionnary);
}

- (CABasicAnimation *)animateMovePlayerToPoint:(CGPoint)point {
    // Convert the point for the view
    CGPoint convertedPoint = [self moveToCoordinate:point];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [_spritePlayer valueForKey:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:convertedPoint];
    animation.duration = 1.2f;
    _spritePlayer.position = convertedPoint;

    // Update the position of the player in the matrice {0,2}
    position = point;
    
    return animation;
}

- (CGPoint)moveToCoordinate:(CGPoint)p {
    CGPoint newPos;
    newPos.x = ((p.y + 1.0) * SIZE_CUBE) - (WIDTH_SPRITE / 2);
    newPos.y = ((p.x + 1.0) * SIZE_CUBE) - (HEIGHT_SPRITE / 2);
    return newPos;
}

#pragma mark - Set Up Animation

- (void)setUpAnimation {
    // Animation
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"sampleIndex"];
    anim.fromValue = [NSNumber numberWithInt:1];
    anim.toValue = [NSNumber numberWithInt:10];
    anim.duration = 0.35f;
    anim.repeatCount = REPEAT_ANIMATION;
    anim.delegate = self;
    
    [_spritePlayer addAnimation:anim forKey:nil];
}

#pragma mark - Animation Delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [NSTimer scheduledTimerWithTimeInterval:TIMER_ANIMATION target:self selector:@selector(setUpAnimation) userInfo:nil repeats:NO];
}

@end
