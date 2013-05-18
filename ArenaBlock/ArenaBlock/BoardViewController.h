//
//  BoardViewController.h
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "ADBGridView.h"
#import "Player.h"

@interface BoardViewController : UIViewController<ADBGridViewDelegate, PlayerDataSourceProtocol> {
   IBOutlet ADBGridView *gridView;
    
    Player *player1;
    Player *player2;
}

@end
