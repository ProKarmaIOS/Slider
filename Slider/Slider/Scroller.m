//
//  Scroller.m
//  Slider
//
//  Created by abhishek on 7/31/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import "Scroller.h"


#define SCROLL_PIXELS 10.0
#define COVER_WIDTH_HEIGHT 128.0
@implementation Scroller

-(id)initWithFrame:(struct CGRect)frame covers:(NSMutableArray *)covers
{
    self = [super initWithFrame:frame];
    if (self) {
        _covers = covers;
       _selectedCover=0;
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.scrollsToTop = NO;
        self.bouncesZoom = NO;
        self.bounces = NO;
        self.cfIntLayer = [[CAScrollLayer alloc] init];
        self.cfIntLayer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height+COVER_WIDTH_HEIGHT);
        
        self.cfIntLayer.position = CGPointMake(160.0, 304.0);
        self.cfIntLayer.frame = frame;
        self.cfIntLayer.scrollMode = kCAScrollVertically;
        
        for (int i=0; i<[_covers count]; i++) {
            NSLog(@"Initializing cfIntLayer layer %d\n",i);
            
            UIImageView * background = [[UIImageView alloc] initWithImage:[_covers objectAtIndex:i]];
            
            background.frame = CGRectMake(0, 0, COVER_WIDTH_HEIGHT, COVER_WIDTH_HEIGHT);
            
            [self.cfIntLayer addSublayer:background.layer];
        }
        
        self.contentSize=CGSizeMake(320.0, (frame.size.height+(SCROLL_PIXELS*([_covers count]-1))));
        
        [self.layer addSublayer:self.cfIntLayer];
        [self  layoutLayer:self.cfIntLayer];
        
    }
    return  self;
    

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _selectedCover=(int)roundf(self.contentOffset.y/SCROLL_PIXELS);
    
    if (_selectedCover>[_covers count]-1) {
        _selectedCover=[_covers count]-1;
    }
    [self layoutLayer:_cfIntLayer];
}


-(void)setSelectedCover:(int)index{
    if (index!=_selectedCover) {
        _selectedCover = index;
        
        [self layoutLayer:_cfIntLayer];
        self.contentOffset=CGPointMake(self.contentOffset.x, _selectedCover*SCROLL_PIXELS);
    }
}

-(void)layoutLayer:(CAScrollLayer*)layer
{
    CALayer * sublayer;
    NSArray * array;
    size_t i,count;
    
    CGRect rect,cfImageRect;
    
    CGSize cellSize,spacing,margin,size;
    
    CATransform3D leftTransform,rightTransfrom,sublayerTransform;
    
    float  zCenterPosition,zSidePosion;
    float  siderSpacingFactor,rowScaleFactor;
    float  angle=0;//1.39;
    int    x;
    
    size = [layer bounds].size;
    zCenterPosition = 0;//60;
    zSidePosion = 0;
    siderSpacingFactor = .85;
    rowScaleFactor = .4;//.55;
    leftTransform = CATransform3DMakeRotation(angle, -1, 0, 0);
    rightTransfrom = CATransform3DMakeRotation(-angle, -1, 0, 0);
    
    margin=CGSizeMake(5.0, 5.0);
    spacing=CGSizeMake(2.0, 2.0);
    
    cellSize=CGSizeMake(COVER_WIDTH_HEIGHT, COVER_WIDTH_HEIGHT);
    
    margin.width+=(size.width-cellSize.width*[_covers count]-spacing.width*([_covers count]-1));
    
    margin.width=floor(margin.width);
    
    array=[layer sublayers];
    count=[array count];
    sublayerTransform=CATransform3DIdentity;
    
    sublayerTransform.m34=-0.006;
    
    
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.3f] forKey:@"animationDuration"];
    
    for (i=0; i<count; i++) {
        sublayer=[array objectAtIndex:i];
        x=i;
        
        rect.size=*(CGSize*)&cellSize;
        rect.origin=CGPointZero;
        cfImageRect=rect;
        
        
        rect.origin.x=size.width/2-cellSize.width/2;
        
        rect.origin.y=margin.height+x*(cellSize.height+spacing.height);
        
        [[sublayer superlayer] setSublayerTransform:sublayerTransform];
        
        
//        if (x<_selectedCover) {
//            rect.origin.y+=cellSize.height*siderSpacingFactor*(float)(_selectedCover-x-rowScaleFactor);
//            
//            sublayer.zPosition=zSidePosion-2.0*(_selectedCover-x);
//            sublayer.transform=leftTransform;
//        }else if (x>_selectedCover){
//            rect.origin.y-=cellSize.height*siderSpacingFactor*(float)(x-_selectedCover-rowScaleFactor);
//            
//            sublayer.zPosition=zSidePosion-2.0*(x-_selectedCover);
//            sublayer.transform=rightTransfrom;
//        }
//        
//        else{
//            sublayer.transform=CATransform3DIdentity;
//            sublayer.zPosition=zCenterPosition;
//            
//            [layer scrollToPoint:CGPointMake(0, rect.origin.y-(([layer bounds].size.height-cellSize.width)/2.0))];
//            
//            layer.position=CGPointMake(160.0f, 240.0f+(_selectedCover*SCROLL_PIXELS));
//        }
        
        
        sublayer.transform=CATransform3DIdentity;
        sublayer.zPosition=zCenterPosition;
        
        [layer scrollToPoint:CGPointMake(0, rect.origin.y-(([layer bounds].size.height-cellSize.width)/2.0))];
        
        layer.position=CGPointMake(160.0f, 240.0f+(_selectedCover*SCROLL_PIXELS));
       
        [sublayer setFrame:rect];
        
    }
    [CATransaction commit];
}

@end
