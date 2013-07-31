//
//  Scroller.h
//  Slider
//
//  Created by abhishek on 7/31/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// defines how much the scroller moves on swipe
// shoukld be greater than one
#define kScrollDistancePixels 10.0

@interface Scroller : UIScrollView <UIScrollViewDelegate>
{
    int _selectedCover;
}

@property (nonatomic, strong) NSMutableArray *deck;
@property (nonatomic, strong) CAScrollLayer *animatedScrollLayer;
@property (nonatomic, assign) int coverHeight;
@property (nonatomic, assign) int coverWidth;

-(id)initWithFrame:(struct CGRect)frame covers:(NSMutableArray*)deck;
-(void)layoutLayer:(CAScrollLayer*)layer;

@end
