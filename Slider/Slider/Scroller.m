//
//  Scroller.m
//  Slider
//
//  Created by abhishek on 7/31/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import "Scroller.h"

@implementation Scroller

-(id)initWithFrame:(struct CGRect)frame covers:(NSMutableArray *)covers
{
    self = [super initWithFrame:frame];
    if (self) {
        _covers = covers;
        
        //set properties of uiscrollview
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self;
        self.scrollsToTop = NO;
        self.bouncesZoom = NO;
        
        //set bounds and frame of CAScrollLayer
        _animatedScrollLayer = [[CAScrollLayer alloc] init];
        _animatedScrollLayer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _animatedScrollLayer.frame = frame;
        
        //add images to the CAScrollLayer
        for (int i = 0; i < [_covers count]; ++i) {
            UIImageView *cover = [[UIImageView alloc] initWithImage:[_covers objectAtIndex:i]];
            [_animatedScrollLayer addSublayer:cover.layer];
        }
        
        //frame height + size of all colapsed menu items
        int contentHeight = frame.size.height + ( kScrollDistancePixels * ([_covers count] - 1) );
        
        self.contentSize = CGSizeMake(frame.size.width, contentHeight);
        
        [self.layer addSublayer:_animatedScrollLayer];
    }
    return self;
}

-(void)layoutLayer:(CAScrollLayer*)layer
{
    
}

@end
