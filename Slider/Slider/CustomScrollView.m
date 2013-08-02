//
//  CustomScrollView.m
//  Slider
//
//  Created by abhishek on 8/1/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import "CustomScrollView.h"

@implementation CustomScrollView

-(id)initWithFrame:(struct CGRect)frame AndOptions:(NSMutableArray *)list
{
    self = [super initWithFrame:frame];
    if (self) {
        //if ([list count] > 30) {
            // list is too large to display with this
            //return self;
        //}
        
        _list = list; //for global access
        
        //set properties of uiscrollview
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self;
        self.scrollsToTop = NO;
        self.bouncesZoom = NO;
        self.layer.shouldRasterize = YES;
        self.opaque = YES;
        self.autoresizesSubviews = YES;
        
        
        kSpacingPixelsTopClosed = (frame.size.height/100);
        kSpacingPixelsClosed = (frame.size.height/50);
        kSpacingPixelsOpen = (frame.size.height/4.9);
        
        kCardHeightPixels = (frame.size.height/2);
        
        if ([_list count] == 4) {
            kSpacingPixelsOpen = (frame.size.height/4.5);
            _selectedCard = 0;
        } else if ([_list count] == 3) {
            kSpacingPixelsOpen = (frame.size.height/3.5);
            _selectedCard = 0;
        } else if ([_list count] == 2) {
            kSpacingPixelsOpen = (frame.size.height/2.5);
            _selectedCard = 0;
        } else if ([_list count] == 1) {
            kSpacingPixelsOpen = (frame.size.height/1.5);
            kCardHeightPixels = (frame.size.height/1.5);
            _selectedCard = 0;
        }
        
        //set bounds and frame of CAScrollLayer
        _animatedScrollLayer = [[CAScrollLayer alloc] init];
        _animatedScrollLayer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _animatedScrollLayer.position = CGPointMake(frame.size.width/2, frame.size.height/2);
        _animatedScrollLayer.scrollMode = kCAScrollVertically;
        _animatedScrollLayer.frame = frame;
        
        currentFrameY = 10;
        
        for (int i = 0; i < [list count]; ++i) {
            UIImageView *cardImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BgImg.png"]];
            cardImageView.frame = CGRectMake(10, currentFrameY, frame.size.width - 20, kCardHeightPixels);
            [cardImageView setUserInteractionEnabled:YES];
            if (i < _selectedCard) {
                currentFrameY += kSpacingPixelsTopClosed;
            } else if (i >= _selectedCard) {
                if (i == _selectedCard) {
                    currentFrameY += kSpacingPixelsOpen;
                }else if (i == _selectedCard + 1) {
                    currentFrameY += kSpacingPixelsOpen;
                } else if (i == _selectedCard + 2) {
                    currentFrameY += kSpacingPixelsOpen;
                } else if (i == _selectedCard + 3) {
                    currentFrameY += kSpacingPixelsOpen;
                } else {
                    currentFrameY += kSpacingPixelsClosed;
                }
            }
            else {
                currentFrameY += kSpacingPixelsClosed;
            }
            
            [_animatedScrollLayer addSublayer:cardImageView.layer];
        }
        
        if ([list count] > 4) {
            _animatedScrollLayer.contentsRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
            self.contentSize = CGSizeMake(frame.size.width, _animatedScrollLayer.frame.size.height + frame.size.height - kSpacingPixelsOpen);
            
        }

        [self.layer addSublayer:_animatedScrollLayer];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //[_animatedScrollLayer scrollToPoint:CGPointMake(0, -self.contentOffset.y)];
    _animatedScrollLayer.position = CGPointMake(self.frame.size.width/2, (self.frame.size.height/2) + self.contentOffset.y);
    
    float scrollPercent = self.contentOffset.y / currentFrameY;
    //NSLog(@"%f", scrollPercent);
    
    _selectedCard = (int)roundf(scrollPercent * [_list count]);
    
    if ( _selectedCard > ([_list count] - 4) ) {
        _selectedCard = [_list count] - 4;
    }
    if ([_list count] <= 3) { // less than four cards
        _selectedCard = 0;
    }
    if (_selectedCard == [_list count]-1) {
        return;
    }
    
    [self layoutLayer:_animatedScrollLayer];
}



-(void)layoutLayer:(CAScrollLayer*)layer
{
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.1f] forKey:@"animationDuration"];
    
    currentFrameY = 10;
    
    for (int i = 0; i < [_list count]; ++i) {
        CALayer *sublayer = [[layer sublayers] objectAtIndex:i];
        [sublayer setFrame:CGRectMake(10, currentFrameY, self.frame.size.width - 20, kCardHeightPixels)];
        if (i < _selectedCard) {
            currentFrameY += kSpacingPixelsTopClosed;
        } else if (i >= _selectedCard) {
            if (i == _selectedCard) {
                currentFrameY += kSpacingPixelsOpen;
            }else if (i == _selectedCard + 1) {
                currentFrameY += kSpacingPixelsOpen;
            } else if (i == _selectedCard + 2) {
                currentFrameY += kSpacingPixelsOpen;
            } else if (i == _selectedCard + 3) {
                currentFrameY += kSpacingPixelsOpen;
            } else {
                currentFrameY += kSpacingPixelsClosed;
            }
        }
        else {
            currentFrameY += kSpacingPixelsClosed;
        }
        
    }
    
    [CATransaction commit];
    
}

//mutator for set selected cover
-(void)setSelectedCard:(int)index
{
    //set the current selection to the index provided
    if ( index != _selectedCard && index < ([_list count] - 4) ) {
        _selectedCard = index;
        [self layoutLayer:_animatedScrollLayer];
        
    } else {
        _selectedCard = 0;
        [self layoutLayer:_animatedScrollLayer];
    }
}

//accessor for selected cover
-(int)getSelectedCard{
    return _selectedCard;
}

@end
