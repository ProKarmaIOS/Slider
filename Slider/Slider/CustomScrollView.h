//
//  CustomScrollView.h
//  Slider
//
//  Created by abhishek on 8/1/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kDistanceFromTopOfFrameToTopCard 10
#define kDistanceFromSideOfFrameToSideOfCard 10
#define kAnimationDurationForSlide 0.6f

@interface CustomScrollView : UIScrollView <UIScrollViewDelegate>
{
    float currentFrameY;
    
    // constants calculated at runtime
    float kSpacingPixelsTopClosed;
    float kSpacingPixelsClosed;
    float kSpacingPixelsOpen;
    float kCardHeightPixels;
}

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, assign) int selectedCard;


-(id)initWithFrame:(struct CGRect)frame AndList:(NSMutableArray*)list;
-(void)initCardsWithList:(NSMutableArray *)list;
@end
