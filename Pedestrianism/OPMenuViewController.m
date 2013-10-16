//
//  OPMenuViewController.m
//  Pedestrianism
//
//  Created by TY on 13-10-15.
//  Copyright (c) 2013年 First. All rights reserved.
//

#import "OPMenuViewController.h"
#import "RippleModel.h"

#define MAIN_WINDOW [[[UIApplication sharedApplication]delegate]window]
#define ROOT_CONTROLLER [MAIN_WINDOW rootViewController]
@interface OPMenuViewController ()

@end

@implementation OPMenuViewController

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
  NSLog(@"菜单界面");
	// Do any additional setup after loading the view.
  NSString *path=[[NSBundle mainBundle]pathForResource:@"MenuList" ofType:@"plist"];
  _menuArr =[[NSMutableArray alloc]initWithContentsOfFile:path];
  //注册消息中心
  isShowing=NO;
  
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toggleSlideBar) name:kSIDE_BAR_SHOULD_SHOW_NOTIFACATION object:nil];
  
  [sideTableView setSeparatorColor:[UIColor blackColor]];
  [sideTableView setBackgroundColor:RGBColorMake(25, 25, 25, 1)];
  
  [self.view.layer setShadowColor:[UIColor blackColor].CGColor];
  [self.view.layer setShadowOffset:CGSizeMake(15, -5)];
  
//  [[[[UIApplication sharedApplication]delegate] window]bringSubviewToFront:self.view];

  //头像图片
  [userHeadImageView.layer setCornerRadius:5.0];
  [userHeadImageView.layer setMasksToBounds:YES];
  UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRipple:)];
  tap.numberOfTapsRequired=1;
  [ROOT_CONTROLLER.view addGestureRecognizer:tap];
}
//动画效果
-(void)tapRipple:(UITapGestureRecognizer*)tap{
  NSLog(@"点击");
  CGPoint point=[tap locationInView:nil];
  RippleModel *_ripple=[[RippleModel alloc]init];
  [_ripple initiateRippleAtLocation:point];
  [_ripple runSimulation];
}

///界面跳转
-(void)toggleSlideBar
{
  if (!isShowing) {
    [self showSideBar];
  }else{
    [self hideSideBar];
  }
}

-(void)showSideBar
{
  [CATransaction begin];
  [UIView animateWithDuration:0.25 animations:^{
    CGAffineTransform trans=ROOT_CONTROLLER.view.transform;
    // trans=CGAffineTransformScale(trans, 0.9, 0.9);
    trans=CGAffineTransformTranslate(trans, 250, 0);
    [self.view setTransform:trans];
    [ROOT_CONTROLLER.view setTransform:trans];
    [self.view.layer setShadowOpacity:0.5];
  }completion:^(BOOL finished) {
    isShowing=YES;
    ROOT_CONTROLLER.view.userInteractionEnabled=NO;
    [self createTap];
  }];
  [CATransaction commit];
}

-(void)hideSideBar
{
//  [CATransaction begin];
  [UIView animateWithDuration:0.25 animations:^{
    [self.view setTransform:CGAffineTransformIdentity];
    [ROOT_CONTROLLER.view setTransform:CGAffineTransformIdentity];
  } completion:^(BOOL finished) {
    isShowing=NO;
    ROOT_CONTROLLER.view.userInteractionEnabled=YES;
    [self closeTap];
    [self.view.layer setShadowOpacity:0];
  }];
//  [CATransaction commit];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tapGesture:(UITapGestureRecognizer *)sender {

  [self hideSideBar];
}
///创建手势
-(void)createTap{
  if (tapGesture==nil) {
    tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired=1;
  }
  [self.view addGestureRecognizer:tapGesture];
}
///关闭手势
-(void)closeTap{
  [self.view removeGestureRecognizer:tapGesture];
}

#pragma mark ----tableview delegates-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return _menuArr.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.row==0) {
    return 100;
  }
  return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.row==0) {
    return _userCell;
  }
  
  NSString *identifier=@"menuCell";
  UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  cell.textLabel.text=_menuArr[indexPath.row-1];
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  UINavigationController *nav=nil;
  switch (indexPath.row) {
    case 0:{
      for (UIView *view in ROOT_CONTROLLER.view.subviews) {
        if ( view.tag>=50000) {
          [view removeFromSuperview];
        }
      }
    }
      break;
    case 1:
      nav=outdoorToolsNav;
      break;
    case 2:
      nav=activityNav;
      break;
    case 3:
      break;
    case 4:
      break;
    case 5:
      break;
    default:
      break;
  }
  [self hideSideBar];
  if (nav) {
    nav.view.tag=50000+indexPath.section*10+indexPath.row;
    double delayInSeconds = 0.05;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      CATransition *transition = [CATransition animation];
      transition.duration = 1.0;
      transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
      transition.type = @"rippleEffect";
      ///  transition.subtype = kCATransitionFromRight;
      // transition.delegate = self;
      [ROOT_CONTROLLER.view.layer addAnimation:transition forKey:nil];
      [OPSetWindow setNavBackground:nav];
      [ROOT_CONTROLLER.view addSubview:nav.view];
    });
  }
}

@end
