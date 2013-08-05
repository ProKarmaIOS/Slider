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
    
    for (int i = 0; i < 12; i++) {
        [list addObject:[NSString stringWithFormat:@"Test %d", i]];
    }
    
	/*CustomScrollView *s = [[CustomScrollView alloc] initWithFrame:CGRectMake(0,
                                                                             548.0/3.0,
                                                                             self.view.frame.size.width,
                                                                             self.view.frame.size.height/3
                                                                             )
                                                       AndOptions:list];
    
    NSLog(@"%f", self.view.frame.size.height);
    
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:s];*/
    
//    UIView *view  = [[[NSBundle mainBundle] loadNibNamed:@"ViewController_iPhone"
//                                                   owner:self
//                                                 options:nil]lastObject];
   
    //CustomScrollView *s = [[view subviews]lastObject];
    [_s initCardsWithList:list];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
