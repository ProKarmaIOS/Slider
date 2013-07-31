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
        
        
    }
    return self;
}

-(void)layoutLayer:(CAScrollLayer*)layer
{
    
}

@end
