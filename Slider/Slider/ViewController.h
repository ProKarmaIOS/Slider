//
//  ViewController.h
//  Slider
//
//  Created by abhishek on 7/31/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scroller.h"


@interface ViewController : UIViewController
@property (nonatomic,strong) Scroller *scroller;
@property (nonatomic,strong) NSMutableArray *covers;
@end
