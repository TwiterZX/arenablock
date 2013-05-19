//
//  PieceGenerator.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "PieceGenerator.h"
#import "Piece.h"

#define kWidthPiece             @"16"
#define kHeightPiece            @"16"
#define kSizeBoard              @"64"

#define kKeyForPiece            @"pieces"
#define kImageKeyForPiece       @"caseblanche"
#define kImageKeyForPiece_end   @"end"
#define kImageKeyForPiece_start @"start"

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
    UIGraphicsBeginImageContext(CGSizeMake([kSizeBoard floatValue], [kSizeBoard floatValue]));
    CGContextRef context = UIGraphicsGetCurrentContext();

    for (int i = 0; i < [[[pieceIdentification valueForKey:kKeyForPiece] objectAtIndex:0] count]; i++)
    {
        NSString *value = [[[pieceIdentification valueForKey:kKeyForPiece] objectAtIndex:0] objectAtIndex:i];
        CGPoint point = CGPointFromString(value);
        if (i == 0) {
            [self addImageToContext:context withImage:[UIImage imageNamed:kImageKeyForPiece_start] atPosition:CGPointMake(point.x, point.y)];
        }
        else if (i == [[[pieceIdentification valueForKey:kKeyForPiece] objectAtIndex:0] count] - 1)
        {
            [self addImageToContext:context withImage:[UIImage imageNamed:kImageKeyForPiece_end] atPosition:CGPointMake(point.x, point.y)];
        }
        else
        {
            [self addImageToContext:context withImage:[UIImage imageNamed:kImageKeyForPiece] atPosition:CGPointMake(point.x, point.y)];
        }
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

- (void)fillArray:(NSMutableArray *)array limit:(NSInteger)lim {
    // We filter
    NSMutableArray *filteredArray = [self filterArrayPieceswithArray:array];
    
    // We add as much pieces as needed
    int end = lim - [array count];
    for (int i = 0 ; i < end ; i++) {
        NSDictionary *piece = [self ramdomPiecesInArray:filteredArray];
        [filteredArray removeObject:piece];

        // Creation de la class piece
        Piece *p = [[Piece alloc] init];
        p.pieceImage = [self createPieceGenerator:piece];
        p.pieceDict = piece;
        p.piecePos = 0;

        [array addObject:p];
    }
}

#pragma mark - Filter array

// Filter the array of pieces with the one we already have
- (NSMutableArray *)filterArrayPieceswithArray:(NSArray *)array {
    NSMutableArray *filteredArray = [NSMutableArray arrayWithArray:_arrayPieces];
    for (NSDictionary *dic in _arrayPieces) {
        for (Piece *piece in array) {
            if ([dic isEqualToDictionary:piece.pieceDict])
                [filteredArray removeObject:dic];
        }
    }
    return filteredArray;
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
