//
//  OPMenuViewController.h
//  Pedestrianism
//
//  Created by TY on 13-10-15.
//  Copyright (c) 2013年 First. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
  UITapGestureRecognizer *tapGesture;
  ///表格数据
  NSMutableArray *_menuArr;
  BOOL isShowing;
  __weak IBOutlet UIImageView *userHeadImageView;
  __weak IBOutlet UITableViewCell *_userCell;
  __weak IBOutlet UITableView *sideTableView;
  //－－－－－导航条－－－－－－
  ///
  __weak IBOutlet UITabBarController *mainTab;
  __weak IBOutlet UINavigationController *loginNav;
  __weak IBOutlet UINavigationController *activityNav;
  __weak IBOutlet UINavigationController *outdoorToolsNav;
  
}

@end
