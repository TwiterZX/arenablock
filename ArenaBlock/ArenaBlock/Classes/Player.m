//
//  Player.m
//  ArenaBlock
//
//  Created by Salhi Yacine on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

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
    [self moveToCoordinate:CGPointMake(0, 0)];

    [self setUpAnimation];
    
    UIView *v = [delegateSprite viewForPlayer:self];
    [v.layer addSublayer:_spritePlayer];
}

- (void)moveToCoordinate:(CGPoint)p {
    CGPoint newPos;
    newPos.x = ((p.y + 1.0) * SIZE_CUBE) - (WIDTH_SPRITE / 2);
    newPos.y = ((p.x + 1.0) * SIZE_CUBE) - (HEIGHT_SPRITE / 2);
    _spritePlayer.position = newPos;
    DLog(@"Point %@", NSStringFromCGPoint(newPos));
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
