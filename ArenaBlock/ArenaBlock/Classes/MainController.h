//
//  MainController.h
//  ArenaBlock
//
//  Created by Riad KRIM on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameCenterManager;
@interface MainController : UIViewController <UIAlertViewDelegate>

@property(strong, nonatomic) GameCenterManager *gameCenterManager;

@end
