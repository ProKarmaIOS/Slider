//
//  CustomScrollView.m
//  Slider
//
//  Created by abhishek on 8/1/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import "CustomScrollView.h"

@implementation CustomScrollView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupScrollViewOptions];
    
    [self resetCurrentFrameY];
}

-(id)initWithFrame:(struct CGRect)frame AndList:(NSMutableArray*)list
{
    self = [super initWithFrame:frame];
    if (self) {
        //if ([list count] > 30) {
            // list is too large to display with this
            //return self;
        //}
        
        _list = list;
        
        [self setupScrollViewOptions];
        
        [self generateConstants];
        
        [self resetCurrentFrameY];
        
        [self initCards];
        
    }
    return self;
}

-(void)setupScrollViewOptions
{
    //self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.delegate = self;
    self.scrollsToTop = NO;
    self.bouncesZoom = NO;
    self.layer.shouldRasterize = YES;
    self.opaque = YES;
    self.autoresizesSubviews = YES;
}

-(void)initCards
{
    for (int i = 0; i < [_list count]; ++i) {
        //UIImageView *cardImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BgImg.png"]];
        //cardImageView.frame = CGRectMake(kDistanceFromSideOfFrameToSideOfCard,
        //                                 currentFrameY,
        //                                 self.frame.size.width - (kDistanceFromSideOfFrameToSideOfCard * 2),
        //                                 kCardHeightPixels);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(kDistanceFromSideOfFrameToSideOfCard,
                                  currentFrameY,
                                  self.frame.size.width - (kDistanceFromSideOfFrameToSideOfCard * 2),
                                  kCardHeightPixels);
        [button setBackgroundImage:[UIImage imageNamed:@"BgImg.png"] forState:UIControlStateNormal];
        [button setTitle:[_list objectAtIndex:i] forState:UIControlStateNormal];
        
        [self updateCurrentFrameY:i];
        
        //[self addSubview:cardImageView];
        [self addSubview:button];
    }
    
    if ([_list count] > 4) {
        self.contentSize = CGSizeMake(self.frame.size.width,
                                      currentFrameY + self.frame.size.height - (kSpacingPixelsOpen * 2));
    }
}

-(void)initCardsWithList:(NSMutableArray *)list
{
    _list = list;
    
    [self generateConstants];
    
    for (int i = 0; i < [_list count]; ++i) {
        UIImageView *cardImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BgImg.png"]];
        cardImageView.frame = CGRectMake(kDistanceFromSideOfFrameToSideOfCard,
                                         currentFrameY,
                                         self.frame.size.width - (kDistanceFromSideOfFrameToSideOfCard * 2),
                                         kCardHeightPixels);
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        button.frame = CGRectMake(kDistanceFromSideOfFrameToSideOfCard,
//                                  currentFrameY,
//                                  self.frame.size.width - (kDistanceFromSideOfFrameToSideOfCard * 2),
//                                  kCardHeightPixels);
//        [button setBackgroundImage:[UIImage imageNamed:@"BgImg.png"] forState:UIControlStateNormal];
//        [button setTitle:[_list objectAtIndex:i] forState:UIControlStateNormal];
        
        [self updateCurrentFrameY:i];
        
        [self addSubview:cardImageView];
        //[self addSubview:button];
    }
    
    if ([_list count] > 4) {
        self.contentSize = CGSizeMake(self.frame.size.width,
                                      currentFrameY + self.frame.size.height - (kSpacingPixelsOpen * 2));
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    [self resetCurrentFrameY];
    
    for (int i = 0; i < [_list count]; ++i) {
        UIView *subview = [[self subviews] objectAtIndex:i];
        
        [subview setFrame:CGRectMake(kDistanceFromSideOfFrameToSideOfCard,
                                     currentFrameY + self.contentOffset.y,
                                     self.frame.size.width - (2 * kDistanceFromSideOfFrameToSideOfCard),
                                     kCardHeightPixels)];
        
        [self updateCurrentFrameY:i];
        
    }
    
    [self updateSelectedCard];
    
    [self resetCurrentFrameY];
    
    for (int i = 0; i < [_list count]; ++i) {
        UIView *subview = [[self subviews] objectAtIndex:i];
        [UIView animateWithDuration:kAnimationDurationForSlide animations:^{
            [subview setFrame:CGRectMake(kDistanceFromSideOfFrameToSideOfCard,
                                         currentFrameY + self.contentOffset.y,
                                         self.frame.size.width - (2 * kDistanceFromSideOfFrameToSideOfCard),
                                         kCardHeightPixels)];
        }];
        
        [self updateCurrentFrameY:i];
    }
}

-(int) updateCurrentFrameY:(int)i
{
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
        return 0;
    }
    return 1;
}

-(void)updateSelectedCard
{
    float scrollPercent = self.contentOffset.y / currentFrameY;
    
    _selectedCard = (int)roundf(scrollPercent * [_list count]);
    
    if ( _selectedCard > ([_list count] - 4) ) {
        _selectedCard = [_list count] - 4;
    }
    if ([_list count] <= 4) { // less than four cards
        _selectedCard = 0;
    }
    if (_selectedCard == [_list count]-1) {
        return;
    }
}

-(void)generateConstants
{
    kSpacingPixelsTopClosed = (self.frame.size.height/100);
    kSpacingPixelsClosed = (self.frame.size.height/50);
    kSpacingPixelsOpen = (self.frame.size.height/4.9);
    
    kCardHeightPixels = (self.frame.size.height/2);
    
    if ([_list count] == 4) {
        kSpacingPixelsOpen = (self.frame.size.height/4.5);
        _selectedCard = 0;
    } else if ([_list count] == 3) {
        kSpacingPixelsOpen = (self.frame.size.height/3.5);
        _selectedCard = 0;
    } else if ([_list count] == 2) {
        kSpacingPixelsOpen = (self.frame.size.height/2.5);
        _selectedCard = 0;
    } else if ([_list count] == 1) {
        kSpacingPixelsOpen = (self.frame.size.height/1.5);
        _selectedCard = 0;
    }
}

-(void) resetCurrentFrameY
{
    currentFrameY = kDistanceFromTopOfFrameToTopCard;
}

@end
