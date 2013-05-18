//
//  PiecesManager.m
//  ArenaBlock
//
//  Created by Salhi Yacine on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "PiecesManager.h"

@implementation PiecesManager

#define RAMDOM(a, b) ((arc4random() % (b - a)) + a)

#pragma mark - Shared instance

static PiecesManager *_instance = nil;

- (PiecesManager *)sharedInstance {
    if (!_instance) {
        _instance = [self init];
    }
    return _instance;
}

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        _arrayPieces = [self loadInformationFromPlist];
    }
    return self;
}

#pragma mark - Load pieces information from plist

- (NSArray *)loadInformationFromPlist {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PiecesList" ofType:@"plist"];
    
#warning - If list downloaded from Server - check file here
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        return [NSArray arrayWithContentsOfFile:path];
    
    DLog(@"Warning - Loading failed ");
    return nil;
}

#pragma mark - Fill Array with Pieces combination

- (void)fillArray:(NSMutableArray **)array limit:(NSInteger)lim {
    // We filter
    NSMutableArray *filteredArray = [NSMutableArray arrayWithArray:_arrayPieces];
    [filteredArray removeObjectsInArray:*array];
    DLog(@"Array filtered %@", filteredArray);
    
    // We add as much pieces as needed
    int end = lim - [*array count];
    for (int i = 0 ; i < end ; i++) {
        NSDictionary *piece = [self ramdomPiecesInArray:filteredArray];
        [*array addObject:piece];
        DLog(@"New generated piece %@", piece);
    }
}

#pragma mark - Random Pieces in array

// Get a ramdom Key From a Dictionary
- (NSDictionary *)ramdomPiecesInArray:(NSArray *)arr {
    int max = [arr count];
    int random = RAMDOM(0, max);
    return [arr objectAtIndex:random];
}

@end
