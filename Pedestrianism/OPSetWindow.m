//
//  OPSetWindow.m
//  Pedestrianism
//
//  Created by TY on 13-10-15.
//  Copyright (c) 2013年 First. All rights reserved.
//

#import "OPSetWindow.h"

@implementation OPSetWindow
+(void)setNavBackground:(UINavigationController*)nav{
//  UIImageView *image=(UIImageView*)[nav.navigationBar viewWithTag:5005];
//  if (image==nil) {
//    image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    image.tag=5005;
//    image.image=[UIImage imageNamed:@"nav-background"];
//    [nav.navigationBar addSubview:image];
//    [nav.navigationBar sendSubviewToBack:image];
//  }
  [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-background"] forBarMetrics:UIBarMetricsDefault];
}
@end
