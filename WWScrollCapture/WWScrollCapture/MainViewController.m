//
//  MainViewController.m
//  WWScrollCapture
//
//  Created by William on 16/1/15.
//  Copyright © 2016年 William. All rights reserved.
//

#import "MainViewController.h"
#import "WWScrollCaptureView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface MainViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightContraint;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (strong, nonatomic) WWScrollCaptureView *captureView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.contentViewHeightContraint.constant = 1000;
    self.myScrollView.delegate = self;
    self.captureView = [[WWScrollCaptureView alloc]initWithPoint:CGPointMake(WIDTH - 70, 90) scollView:self.myScrollView succeed:^{
        NSLog(@"保存成功");
    } failed:^{
        NSLog(@"保存失败");
    }];
    [self.view addSubview:self.captureView];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.1];/* 异步调用下面的代理回调 否则不会执行 */
    self.captureView.hidden = YES;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.captureView.hidden = NO;
}

@end
