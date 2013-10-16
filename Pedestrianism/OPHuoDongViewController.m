//
//  OPHuoDongViewController.m
//  Pedestrianism
//
//  Created by TY on 13-10-15.
//  Copyright (c) 2013年 First. All rights reserved.
//

#import "OPHuoDongViewController.h"

@interface OPHuoDongViewController ()

@end

@implementation OPHuoDongViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  NSLog(@"活动中心界面");
  // Do any additional setup after loading the view from its nib.
  //调整导航条
  self.navigationItem.title=@"活动";
  UIButton *backBut=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
  [backBut setImage:[UIImage imageNamed:@"main-menu-button"] forState:UIControlStateNormal];
  [backBut setImage:[UIImage imageNamed:@"main-menu-button-hl"] forState:UIControlStateHighlighted];
  [backBut addTarget:self action:@selector(toggleSideBar:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *backBarButton=[[UIBarButtonItem alloc]initWithCustomView:backBut];
  [self.navigationItem setLeftBarButtonItem:backBarButton];
}
-(void)toggleSideBar:(id)sender
{
  [[NSNotificationCenter defaultCenter]postNotificationName:kSIDE_BAR_SHOULD_SHOW_NOTIFACATION object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
