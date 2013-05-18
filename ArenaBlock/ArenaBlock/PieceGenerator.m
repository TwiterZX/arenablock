//
//  PieceGenerator.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "PieceGenerator.h"
#import "Piece.h"

#define kWidthPiece             @"160"
#define kHeightPiece            @"160"
#define kSizeBoard              @"640"

#define kKeyForPiece            @"pieces"

#define RAMDOM(a, b) ((arc4random() % (b - a)) + a)

@implementation PieceGenerator

static  PieceGenerator *_instance = nil;

#pragma mark - Shared instance

+ (PieceGenerator *)sharedInstance {
    if (!_instance) {
        _instance = [[self alloc ] init];
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


#pragma mark - Create Piece From Dictionnary

- (UIImage *)createPieceGenerator:(NSDictionary *)pieceIdentification
{
    
    CGFloat maxWidth = 0.f;
    CGFloat maxHeight = 0.f;
    
    [[pieceIdentification valueForKey:kKeyForPiece] objectAtIndex:0];
    
//    NSMutableDictionary *_pieceCoordonates = [NSMutableDictionary dictionary];
//    
//    NSLog(@"SCREEN WIDHT : %f", [[UIScreen mainScreen] bounds].size.width );
//    
//    
//    NSValue *value_1 = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
//    NSValue *value_2 = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
//    NSValue *value_3 = [NSValue valueWithCGPoint:CGPointMake(0, 2)];
//    NSValue *value_4 = [NSValue valueWithCGPoint:CGPointMake(0, 3)];
//    
//    
//
//    
//    NSArray *position_1 = [[NSArray alloc] initWithObjects:value_1, value_2, value_3, value_4 , nil];
    
    UIGraphicsBeginImageContext(CGSizeMake([kSizeBoard floatValue], [kSizeBoard floatValue]));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSString *value in [[pieceIdentification valueForKey:kKeyForPiece] objectAtIndex:0]) {
        
        CGPoint point = CGPointFromString(value);
        
        NSLog(@"X : %f Y : %f", point.x, point.y);
        
        [self addImageToContext:context withImage:[UIImage imageNamed:@"piece_160x160"] atPosition:CGPointMake(point.x, point.y)];
        
        NSLog(@"value : %@", value);
        if (maxWidth < point.y) {
            maxWidth = point.y;
        }
        if (maxHeight < point.x) {
            maxHeight = point.x;
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    maxWidth =  maxWidth * [kWidthPiece floatValue];
    maxHeight =  maxHeight * [kHeightPiece floatValue];
    UIImage *imageCropped = [self imageWithImage:image cropAtSize:CGSizeMake(maxWidth+[kWidthPiece floatValue], maxHeight+[kHeightPiece floatValue])];
    
    
    return imageCropped;
    
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
        [filteredArray removeObject:piece];

        // Creation de la class piece
        Piece *p = [[Piece alloc] init];
        p.pieceImage = [self createPieceGenerator:piece];
        p.pieceDict = piece;
        p.piecePos = 0;

        [*array addObject:p];
    }
}

#pragma mark - Random Pieces in array

// Get a ramdom Key From a Dictionary
- (NSDictionary *)ramdomPiecesInArray:(NSArray *)arr {
    int max = [arr count];
    int random = RAMDOM(0, max);
    return [arr objectAtIndex:random];
}

#pragma Playing With context methods

- (void)addImageToContext:(CGContextRef)context withImage:(UIImage *)imageB atPosition:(CGPoint)position
{
    CGImageRef firstImageRef = imageB.CGImage;
    
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    if (position.x != 0) {
        position.x =  position.x * [kWidthPiece floatValue];
    }
    if (position.y != 0) {
        position.y =  position.y * [kWidthPiece floatValue];
    }
    [imageB drawInRect:CGRectMake(position.y, position.x, firstWidth, firstHeight)];
}


- (UIImage *)imageWithImage:(UIImage *)image cropAtSize:(CGSize)size
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, size.width, size.height));
    
    return [UIImage imageWithCGImage:imageRef];
}


@end
