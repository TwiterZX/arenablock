//
//  PieceGenerator.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "PieceGenerator.h"

#define kWidthPiece             @"160"
#define kHeightPiece            @"160"
#define kSizeBoard              @"640"


@implementation PieceGenerator


#pragma Get Piece From Dictionnary


+ (UIImage *)createPieceGenerator:(NSDictionary *)pieceCoordonates
{
    
    CGFloat maxWidth = 0.f;
    CGFloat maxHeight = 0.f;
    
    NSMutableDictionary *_pieceCoordonates = [NSMutableDictionary dictionary];
    
    NSLog(@"SCREEN WIDHT : %f", [[UIScreen mainScreen] bounds].size.width );
    
    
    NSValue *value_1 = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue *value_2 = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSValue *value_3 = [NSValue valueWithCGPoint:CGPointMake(0, 2)];
    NSValue *value_4 = [NSValue valueWithCGPoint:CGPointMake(0, 3)];
    
    NSArray *position_1 = [[NSArray alloc] initWithObjects:value_1, value_2, value_3, value_4 , nil];
    
    UIGraphicsBeginImageContext(CGSizeMake([kSizeBoard floatValue], [kSizeBoard floatValue]));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSValue *value in position_1) {
        [self addImageToContext:context withImage:[UIImage imageNamed:@"piece_160x160"] atPosition:CGPointMake([value CGPointValue].x, [value CGPointValue].y)];
        
        if (maxWidth < [value CGPointValue].y) {
            maxWidth = [value CGPointValue].y;
        }
        if (maxHeight < [value CGPointValue].x) {
            maxHeight = [value CGPointValue].x;
        }
        
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    maxWidth =  maxWidth * [kWidthPiece floatValue];
    maxHeight =  maxHeight * [kHeightPiece floatValue];
    UIImage *imageCropped = [self imageWithImage:image cropAtSize:CGSizeMake(maxWidth+[kWidthPiece floatValue], maxHeight+[kHeightPiece floatValue])];
    
    return imageCropped;
    
}

#pragma Playing With context methods

+ (void)addImageToContext:(CGContextRef)context withImage:(UIImage *)imageB atPosition:(CGPoint)position
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


+ (UIImage *)imageWithImage:(UIImage *)image cropAtSize:(CGSize)size
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, size.width, size.height));
    
    return [UIImage imageWithCGImage:imageRef];
}


@end
