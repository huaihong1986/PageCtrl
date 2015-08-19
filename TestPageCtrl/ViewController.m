//
//  ViewController.m
//  TestPageCtrl
//
//  Created by Hu Aihong on 15-8-6.
//  Copyright (c) 2015年 ChinaCloud. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize images;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [super viewDidLoad];
    //初始化数组，存储滚动视图的图片
    self.images = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"fengmian1.png"],[UIImage imageNamed:@"fengmian2.png"],[UIImage imageNamed:@"fengmian3.png"], nil];
    
  
   
   
    //设置视图的背景颜色
    self.view.backgroundColor = [UIColor blackColor];
    //调用 setuoPage方法
    [self setupPage:nil];
}


//改变滚动视图的方法实现
- (void)setupPage:(id)sender
{
    //设置委托
    self.scrollView.delegate = self;
    //设置背景颜色
    self.scrollView.backgroundColor = [UIColor blackColor];
    //设置取消触摸
    self.scrollView.canCancelContentTouches = NO;
    //设置滚动条类型
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //是否自动裁切超出部分
    self.scrollView.clipsToBounds = YES;
    //设置是否可以缩放
    self.scrollView.scrollEnabled = YES;
    //设置是否可以进行画面切换
    self.scrollView.pagingEnabled = YES;
    //设置在拖拽的时候是否锁定其在水平或者垂直的方向
    self.scrollView.directionalLockEnabled = NO;
    //隐藏滚动条设置（水平、跟垂直方向）
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    //用来记录页数
    NSUInteger pages = 0;
    //用来记录scrollView的x坐标
    int originX = 0;
    for(UIImage *image in self.images)
    {
        //创建一个视图
        UIImageView *pImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        //设置视图的背景色
        pImageView.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
        //设置imageView的背景图
        [pImageView setImage:image];
        //给imageView设置区域
        CGRect rect = self.scrollView.frame;
        rect.origin.x = originX;
        rect.origin.y = 0;
        rect.size.width = self.scrollView.frame.size.width;
        rect.size.height = self.scrollView.frame.size.height;
        pImageView.frame = rect;
        //设置图片内容的显示模式(自适应模式)
        pImageView.contentMode = UIViewContentModeScaleAspectFill;
        //把视图添加到当前的滚动视图中
        [self.scrollView addSubview:pImageView];
        //下一张视图的x坐标:offset为:self.scrollView.frame.size.width.
        originX += self.scrollView.frame.size.width;
        //记录scrollView内imageView的个数
        pages++;
    }
    //设置页码控制器的响应方法
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    //设置总页数
    self.pageControl.numberOfPages = pages;
    //默认当前页为第一页
    self.pageControl.currentPage = 0;
    //为页码控制器设置标签
    self.pageControl.tag = 110;
    //设置滚动视图的位置
    [self.scrollView setContentSize:CGSizeMake(originX, self.scrollView.bounds.size.height)];
}
//改变页码的方法实现
- (void)changePage:(id)sender
{
    NSLog(@"指示器的当前索引值为:%i",self.pageControl.currentPage);
    //获取当前视图的页码
    CGRect rect = self.scrollView.frame;
    //设置视图的横坐标，一幅图为320*460，横坐标一次增加或减少320像素
    rect.origin.x = self.pageControl.currentPage * self.scrollView.frame.size.width;
    //设置视图纵坐标为0
    rect.origin.y = 0;
    //scrollView可视区域
    [self.scrollView scrollRectToVisible:rect animated:YES];
}
#pragma mark-----UIScrollViewDelegate---------
//实现协议UIScrollViewDelegate的方法，必须实现的
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //获取当前视图的宽度
    //CGFloat pageWith = scrollView.frame.size.width;
    //根据scrolView的左右滑动,对pageCotrol的当前指示器进行切换(设置currentPage)
    //int page = floor((scrollView.contentOffset.x - pageWith/2)/pageWith)+1;
    int page = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    NSLog(@"TestPag%d",page);
    //切换改变页码，小圆点
    self.pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
