//
//  GameCenterManager.h
//  ArenaBlock
//
//  Created by Riad KRIM on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameCenterManager : NSObject

+ (BOOL)isGameCenterAvailable;
- (void)authenticateLocalUser;

@end
