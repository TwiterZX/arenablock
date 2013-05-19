//
//  AppDelegate.m
//  ArenaBlock
//
//  Created by Riad KRIM on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "SoundManager.h"
#import "AppDelegate.h"
#import "PieceGenerator.h"
#import "WebServiceClient.h"

@implementation AppDelegate
@synthesize bankOfSound;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

   // [self initAllSounds];
//    
//    [WebServiceClient sharedInstance];
//    
    return YES;
}

- (void)initAllSounds
{
    bankOfSound = [NSMutableDictionary dictionary];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Jungle.wav", [[NSBundle mainBundle] resourcePath]]];
    Sound *jungle = [[Sound alloc] initWithContentsOfURL:url];
    jungle.volume = 1.f;
    [bankOfSound setValue:jungle forKey:@"Jungle"];
    
    url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Bonus.wav", [[NSBundle mainBundle] resourcePath]]];
    Sound *bonus = [[Sound alloc] initWithContentsOfURL:url];
  
    [bankOfSound setValue:bonus forKey:@"Bonus"];
    
    url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Campain.wav", [[NSBundle mainBundle] resourcePath]]];
    Sound *campain = [[Sound alloc] initWithContentsOfURL:url];
    
    [bankOfSound setValue:campain forKey:@"Campain"];
    
    url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Move.wav", [[NSBundle mainBundle] resourcePath]]];
    Sound *move = [[Sound alloc] initWithContentsOfURL:url];
    
    [bankOfSound setValue:move forKey:@"Move"];

    url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Rotate.wav", [[NSBundle mainBundle] resourcePath]]];
    Sound *rotate = [[Sound alloc] initWithContentsOfURL:url];
    
    [bankOfSound setValue:rotate forKey:@"Rotate"];

    url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Push.wav", [[NSBundle mainBundle] resourcePath]]];
    Sound *push = [[Sound alloc] initWithContentsOfURL:url];

    
    [bankOfSound setValue:push forKey:@"Push"];

    url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Wrong.wav", [[NSBundle mainBundle] resourcePath]]];
    Sound *wrong = [[Sound alloc] initWithContentsOfURL:url];


    [bankOfSound setValue:wrong forKey:@"Wrong"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
