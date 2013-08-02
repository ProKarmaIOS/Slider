//
//  CustomScrollView.h
//  Slider
//
//  Created by abhishek on 8/1/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomScrollView : UIScrollView <UIScrollViewDelegate>
{
    float currentFrameY;
    float kSpacingPixelsTopClosed;
    float kSpacingPixelsClosed;
    float kSpacingPixelsOpen;
    float kCardHeightPixels;
}
@property (nonatomic, strong) CAScrollLayer *animatedScrollLayer;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, assign) int selectedCard;


-(id)initWithFrame:(struct CGRect)frame AndOptions:(NSMutableArray*)list;
-(void)layoutLayer:(CAScrollLayer*)layer;

@end
