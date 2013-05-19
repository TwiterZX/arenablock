//
//  GameManager.h
//  ArenaBlock
//
//  Created by Salhi Yacine on 19/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

@class Player;

@interface GameManager : NSObject {
}

@property (nonatomic, strong) Player *player1;
@property (nonatomic, strong) Player *player2;
@property (nonatomic, assign) NSInteger idGame;

+ (GameManager *)sharedInstance;

- (void)createGameWithInformation:(NSDictionary *)dic;
- (Player *)fetchPlayerHost;
- (Player *)fetchPlayerNotHost;
- (void)gameHadBeenJoined;

@end
