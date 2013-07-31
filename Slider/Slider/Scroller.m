//
//  Scroller.m
//  Slider
//
//  Created by abhishek on 7/31/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import "Scroller.h"

@implementation Scroller

-(id)initWithFrame:(struct CGRect)frame covers:(NSMutableArray *)deck
{
    self = [super initWithFrame:frame];
    if (self) {
        _deck = deck;
        
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
        for (int i = 0; i < [_deck count]; ++i) {
            UIImageView *card = [[UIImageView alloc] initWithImage:[_deck objectAtIndex:i]];
            [_animatedScrollLayer addSublayer:card.layer];
        }
        
        //frame height + size of all colapsed menu items
        int contentHeight = frame.size.height + ( kScrollDistancePixels * ([_deck count] - 1) );
        
        self.contentSize = CGSizeMake(frame.size.width, contentHeight);
        
        [self.layer addSublayer:_animatedScrollLayer];
        [self layoutLayer:_animatedScrollLayer];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // the amount scrolled in the scrollView
    _selectedCover = (int)roundf(self.contentOffset.y/kScrollDistancePixels);
    
    // check if end is reached
    if ( _selectedCover > ([_deck count] - 4) ) {
        _selectedCover = [_deck count] - 4;
    } else { // less than four cards
        _selectedCover = 0;
    }
    
    // update the CAScrollView based on how much the scroll view has scrolled
    [self layoutLayer:_animatedScrollLayer];
}

//mutator for set selected cover
-(void)setSelectedCover:(int)index
{
    //set the current selection to the index provided
    if ( index != _selectedCover && index < ([_deck count] - 4) ) {
        _selectedCover = index;
        
        [self layoutLayer:_animatedScrollLayer];
        
        self.contentOffset = CGPointMake(self.contentOffset.x, _selectedCover * kScrollDistancePixels);
        
    } else {
        [self layoutLayer:_animatedScrollLayer];
        
        self.contentOffset = CGPointMake(self.contentOffset.x, _selectedCover * kScrollDistancePixels);
        
        _selectedCover = 0;
    }
}

//accessor for selected cover
-(int)getSelectedCover{
    return _selectedCover;
}

-(void)layoutLayer:(CAScrollLayer*)layer
{
    CALayer *card;
    NSArray *sublayerArray;
    
}

@end
