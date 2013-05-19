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

@implementation Player

#define SIZE_CUBE   80  // half of a case
#define WIDTH_SPRITE    80.0
#define HEIGHT_SPRITE   80.0
#define REPEAT_ANIMATION    2.0

#define TIMER_ANIMATION     5.0

#pragma mark - Init player

- (id)initWithDelegate:(id<PlayerDataSourceProtocol>)del {
    self = [super init];
    if (self) {
        delegateSprite = del;
        [self initSprite];
    }
    return self;
}

#pragma mark - Init sprite

- (void)initSprite {
    // Sprite
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sprite_idle" ofType:@"png"];
    CGImageRef richterImg = [UIImage imageWithContentsOfFile:path].CGImage;
    CGSize fixedSize = CGSizeMake(WIDTH_SPRITE, HEIGHT_SPRITE);
    _spritePlayer = [MCSpriteLayer layerWithImage:richterImg sampleSize:fixedSize];
    _spritePlayer.position = [self moveToCoordinate:CGPointMake(0, 3)];
    position = CGPointMake(0, 3);

    [self setUpAnimation];
    
    UIView *v = [delegateSprite viewForPlayer:self];
    [v.layer addSublayer:_spritePlayer];
}

#pragma mark - Getter

- (CGPoint)position {
    return position;
}

#pragma mark - Move player

- (void)movePlayerWithPiece:(Piece *)p {

    // Generate animation
    NSArray *pp = [[p.pieceDict objectForKey:@"pieces"] objectAtIndex:p.piecePos];
    NSArray *ppConverted = [MoveManager getPathAccordingToPiece:pp andPlayerPosition:position];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0, end = [ppConverted count]; i < end; i++) {
        NSString *s = [ppConverted objectAtIndex:i];
        [array addObject:[self animateMovePlayerToPoint:CGPointFromString(s)]];
    }

    // Animate whole group
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.5 * [array count];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    group.animations = array;

    [_spritePlayer addAnimation:group forKey:@"allMyAnimations"];
    
    DLog(@"End move %@", NSStringFromCGPoint(_spritePlayer.position));
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
