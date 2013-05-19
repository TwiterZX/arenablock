//
//  GameManager.m
//  ArenaBlock
//
//  Created by Salhi Yacine on 19/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "Player.h"
#import "GameManager.h"

@implementation GameManager

@synthesize player1=_player1;
@synthesize player2=_player2;
@synthesize idGame=_idGame;

static GameManager *_instance = nil;

+ (id)sharedInstance {
    if (_instance == nil) {
        _instance = [[GameManager alloc] init];
    }
    return _instance;
}


- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)createGameWithInformation:(NSDictionary *)dic {
    _idGame = [[dic objectForKey:@"id"] intValue];
    _player1 = [[Player alloc] initWithHost:[[dic objectForKey:@"is_host"] boolValue]];
}

- (void)gameHadBeenJoined {
    _player2 = [[Player alloc] initWithHost:FALSE];
}

// Get Host
- (Player *)fetchPlayerHost {
    if (_player1.isHost == TRUE)
        return _player1;
    return _player2;
}

// Get Not host
- (Player *)fetchPlayerNotHost {
    if (_player1.isHost == FALSE)
        return _player1;
    return _player2;
}

@end
