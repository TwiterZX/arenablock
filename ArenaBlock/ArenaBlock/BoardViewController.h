//
//  BoardViewController.h
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "PiecePickerViewController.h"
#import "ADBGridView.h"
#import "Player.h"
#import "WebServiceClient.h"

@interface BoardViewController : UIViewController<ADBGridViewDelegate, PlayerDataSourceProtocol, PiecePickerDelegateProtocol, WebServiceProtocol>
{
   IBOutlet ADBGridView *gridView;
}

@property (nonatomic, assign)   BOOL isHost;

@end
