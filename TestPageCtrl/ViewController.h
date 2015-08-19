//
//  ViewController.h
//  TestPageCtrl
//
//  Created by Hu Aihong on 15-8-6.
//  Copyright (c) 2015年 ChinaCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>{
    
   
}
//滚动视图对象
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
//视图中小圆点，对应视图的页码
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
//动态数组对象，存储图片
@property (retain, nonatomic)  NSMutableArray *images; 

@end
