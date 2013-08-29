//
//  ViewController.m
//  Slider
//
//  Created by abhishek on 7/31/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.covers = [NSMutableArray array];
    
    for (int i=1; i<=6; i++) {
        NSLog(@"Loading demoo image %d \n",i);
      
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"3.png"]];
        
        [self.covers addObject:image];
    }
    
    self.scroller = [[Scroller alloc] initWithFrame:self.view.frame covers:self.covers];
    self.view = self.scroller;
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
