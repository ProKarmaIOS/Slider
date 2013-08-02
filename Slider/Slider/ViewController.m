//
//  ViewController.m
//  Slider
//
//  Created by abhishek on 8/1/13.
//  Copyright (c) 2013 kaiser. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *list =[ [NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        [list addObject:[NSString stringWithFormat:@"Test %d", i]];
    }
    
	CustomScrollView *s = [[CustomScrollView alloc] initWithFrame:CGRectMake(0,
                                                                             0,
                                                                             self.view.frame.size.width,
                                                                             self.view.frame.size.height/3
                                                                             )
                                                       AndOptions:list];
    
    
    
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:s];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
