//
//  GameCenterManager.m
//  ArenaBlock
//
//  Created by Riad KRIM on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "GameCenterManager.h"
#import "AppDelegate.h"

@implementation GameCenterManager



+ (BOOL)isGameCenterAvailable {
	// check for presence of GKLocalPlayer API
	Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
	
	// check if the device is running iOS 4.1 or later
	NSString *reqSysVer = @"4.1";
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
	BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
	
	return (gcClass && osVersionSupported);
}

- (void)authenticateLocalUser {
    if([GKLocalPlayer localPlayer].authenticated == NO) {

        [GKLocalPlayer localPlayer].authenticateHandler = ^(UIViewController *viewController, NSError *error) {
            NSLog(@"authenticateHandler");
            if (viewController != nil) {
                NSLog(@"presenting viewController");
                AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                [appDelegate.window.rootViewController presentViewController:viewController animated:YES completion:nil];
            }
            else if ([GKLocalPlayer localPlayer].isAuthenticated) {
                NSLog(@"player isAuthenticated");
//                [self authenticatedGC];
            }
            else {
                NSLog(@"GameCenter Disable");
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Center" message:@"" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Retry", nil];
//                [alert show];
//                [self disableGC];
            }
        };
        
    }
    
        
//		[[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error)
//         {
//             [self callDelegateOnMainThread: @selector(processGameCenterAuth:) withArg: NULL error: error];
//         }];
//	}
    
}

@end
