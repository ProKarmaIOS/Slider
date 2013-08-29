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
<<<<<<< HEAD
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
=======
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.covers = [NSMutableArray array];
    
    for (int i=1; i<=6; i++) {
        NSLog(@"Loading demoo image %d \n",i);
      
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"3.png"]];
        
        [self.covers addObject:image];
    }
    
    self.scroller = [[Scroller alloc] initWithFrame:self.view.frame covers:self.covers];
    self.view = self.scroller;
  
>>>>>>> D
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
