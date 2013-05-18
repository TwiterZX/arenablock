//
//  ADBImageView.h
//  ADBImageView
//
//  Created by Alberto De Bortoli on 26/02/12.
//  Copyright (c) 2012 Alberto De Bortoli. All rights reserved.
//  Caching functionalities taken from Toto Tvalavadze's TCImageView.
//

#import <Foundation/Foundation.h>

@class ADBImageView;

@protocol ADBImageViewDelegate <NSObject>
@optional
- (void)ADBImageView:(ADBImageView *)view willUpdateImage:(UIImage *)image;
- (void)ADBImageView:(ADBImageView *)view didLoadImage:(UIImage *)image;
- (void)ADBImageView:(ADBImageView *)view failedLoadingWithError:(NSError *)error;
- (void)ADBImageViewDidSingleTap:(ADBImageView *)view;
- (void)ADBImageViewDidLongPress:(ADBImageView *)view;
@end

@interface ADBImageView : UIImageView {
    
    UIImageView *_placeholder;
    
	id <ADBImageViewDelegate> __unsafe_unretained _delegate;
}

@property (nonatomic, unsafe_unretained) id<ADBImageViewDelegate> delegate;

- (void)setImageWithURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholderImage;

@end
