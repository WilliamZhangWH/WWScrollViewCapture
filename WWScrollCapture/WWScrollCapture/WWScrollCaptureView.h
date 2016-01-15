//
//  WWScrollCaptureView.h
//  WWScrollCapture
//
//  Created by William on 16/1/15.
//  Copyright © 2016年 William. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SavingSucceedBlock)();
typedef void (^SavingFaidedBlock)();

@interface WWScrollCaptureView : UIView

- (instancetype) initWithPoint:(CGPoint)point scollView:(UIScrollView *)scrollView succeed:(SavingSucceedBlock)succeedBlock failed:(SavingFaidedBlock)failedBlock;

@end
