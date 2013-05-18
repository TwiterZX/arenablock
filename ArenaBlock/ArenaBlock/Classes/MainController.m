//
//  MainController.m
//  ArenaBlock
//
//  Created by Riad KRIM on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "MainController.h"
#import "GameCenterManager.h"



#define kAlertViewExitTag       1

@interface MainController ()

@end

@implementation MainController
@synthesize gameCenterManager = _gameCenterManager;



- (GameCenterManager *)gameCenterManager {
    if (!_gameCenterManager) {
        _gameCenterManager = nil;
    }
    return _gameCenterManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([GameCenterManager isGameCenterAvailable]) {
        NSLog(@"GameCenter is Available");
        
        GameCenterManager *gameCenterManager = [[GameCenterManager alloc] init];
        [gameCenterManager authenticateLocalUser];

    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"App Requirements" message:@"Game Center Support Required!, app will exit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = kAlertViewExitTag;
        [alert show];
    }
    
    /*

    self.currentLeaderBoard= kEasyLeaderboardID;
	
	self.currentScore= 0;
	
	[super viewDidLoad];
	if([GameCenterManager isGameCenterAvailable])
	{
		self.gameCenterManager= [[[GameCenterManager alloc] init] autorelease];
		[self.gameCenterManager setDelegate: self];
		[self.gameCenterManager authenticateLocalUser];
		
		[self updateCurrentScore];
	}
	else
	{
		[self showAlertWithTitle: @"Game Center Support Required!"
						 message: @"The current device does not support Game Center, which this sample requires."];
	}
    */
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"alertView:clickedButtonAtIndex: %d", alertView.tag);
    if (alertView.tag == kAlertViewExitTag) {
        exit(0);
    }
}


@end
