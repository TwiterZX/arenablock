//
//  ADBImageView.m
//  ADBImageView
//
//  Created by Alberto De Bortoli on 26/02/12.
//  Copyright (c) 2012 Alberto De Bortoli. All rights reserved.
//  Caching functionalities taken from Toto Tvalavadze's TCImageView.
//

#import "ADBImageView.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ADBImageView

@synthesize delegate = _delegate;

#pragma mark - Initializers

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.clipsToBounds = YES;
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageSingleTapped:)];
        [self addGestureRecognizer:tgr];
        tgr.numberOfTapsRequired = 1;
        tgr.numberOfTouchesRequired = 1;
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imageLongPressed:)];
        [self addGestureRecognizer:lpgr];
        
        [self setUserInteractionEnabled:YES];
        [self setOpaque:YES];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.clipsToBounds = YES;
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageSingleTapped:)];
        [self addGestureRecognizer:tgr];
        tgr.numberOfTapsRequired = 1;
        tgr.numberOfTouchesRequired = 1;
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imageLongPressed:)];
        [self addGestureRecognizer:lpgr];
        
        [self setUserInteractionEnabled:YES];
        [self setOpaque:YES];
    }
    
    return self;
}

#pragma mark - ADBImageView

- (void)setImageWithURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholderImage;
{
    _placeholder = [[UIImageView alloc] initWithImage:placeholderImage];
    _placeholder.frame = self.bounds;
    [self addSubview:_placeholder];    
}

#pragma mark - Gesture actions

- (void)imageSingleTapped:(UIGestureRecognizer *)recognizer
{
    if ([_delegate respondsToSelector:@selector(ADBImageViewDidSingleTap:)]) {
        [_delegate ADBImageViewDidSingleTap:(ADBImageView *)[recognizer view]];
    }
}

- (void)imageLongPressed:(UIGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if ([_delegate respondsToSelector:@selector(ADBImageViewDidLongPress:)]) {
            [_delegate ADBImageViewDidLongPress:(ADBImageView *)[recognizer view]];
        }
    }
}

@end
