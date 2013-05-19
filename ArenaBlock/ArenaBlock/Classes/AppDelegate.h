//
//  AppDelegate.h
//  ArenaBlock
//
//  Created by Riad KRIM on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundManager.h"

#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSMutableDictionary *bankOfSound;
@property (nonatomic, strong) Sound *s;
@end
