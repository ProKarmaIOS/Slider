//
//  Scroller.h
//  Slider
//
//  Created by abhishek on 7/31/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Scroller : UIScrollView <UIScrollViewDelegate>

@property NSMutableArray *covers;
@property (nonatomic,strong) CAScrollLayer   * cfIntLayer;
@property (nonatomic,getter = getSelectedCover) int selectedCover;
-(id)initWithFrame:(struct CGRect)frame covers:(NSMutableArray*)covers;
-(void)layoutLayer:(CAScrollLayer*)layer;

@end
