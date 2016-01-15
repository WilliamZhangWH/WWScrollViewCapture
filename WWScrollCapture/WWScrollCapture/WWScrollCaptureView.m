//
//  WWScrollCaptureView.m
//  WWScrollCapture
//
//  Created by William on 16/1/15.
//  Copyright © 2016年 William. All rights reserved.
//

#import "WWScrollCaptureView.h"
#define Length_Of_Side 50

@interface WWScrollCaptureView () <UIScrollViewDelegate>

@property (nonatomic, copy) SavingSucceedBlock succeedBlock;
@property (nonatomic, copy) SavingFaidedBlock failedBlock;

@property (nonatomic, strong) UIButton * clickBtn;

@property (nonatomic, strong) UIScrollView * contentScrollView;

@end

@implementation WWScrollCaptureView

- (instancetype) initWithPoint:(CGPoint)point scollView:(UIScrollView *)scrollView succeed:(SavingSucceedBlock)succeedBlock failed:(SavingFaidedBlock)failedBlock {
    self = [super initWithFrame:CGRectMake(point.x, point.y + scrollView.frame.origin.y, Length_Of_Side, Length_Of_Side)];
    if (self) {
        [self configView];
        [self clickBtn];
        self.contentScrollView = scrollView;
        self.succeedBlock = succeedBlock;
        self.failedBlock = failedBlock;
    }
    return self;
}

- (void)configView {
    [self.layer setCornerRadius:self.frame.size.width/2];
    [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]];
    [self.layer setShadowOffset:CGSizeMake(3, 3)];
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 3;
}

- (UIButton *)clickBtn {
    if (!_clickBtn) {
        _clickBtn = [[UIButton alloc]initWithFrame:self.bounds];
        [_clickBtn setBackgroundColor:[UIColor clearColor]];
        [_clickBtn addTarget:self action:@selector(scrollCapture) forControlEvents:UIControlEventTouchUpInside];
        [_clickBtn setImage:[UIImage imageNamed:@"iconfont-album"] forState:UIControlStateNormal];
        [self addSubview:_clickBtn];
    }
    return _clickBtn;
}

- (void)scrollCapture {
    UIImage *savingPicture = [self captureScrollView:self.contentScrollView];
    [self savePictureToAlbumWithImage:savingPicture];
}
/* 截取scrollView里面的图片 */
- (UIImage *)captureScrollView:(UIScrollView *)scrollView{
    UIImage* image = nil;
    UIGraphicsBeginImageContext(scrollView.contentSize);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}
/* 保存图片 */
- (void)savePictureToAlbumWithImage:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
/* 改变保存图片按钮状态 */
- (void)changeButtonState {
    self.clickBtn.enabled = NO;
    [_clickBtn setImage:[UIImage imageNamed:@"iconfont-saved"] forState:UIControlStateNormal];
    self.clipsToBounds = YES;
}
/* 图片保存状态返回 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [self changeButtonState];
        if (self.succeedBlock) {
            self.succeedBlock();
        }
    }else{
        if (self.failedBlock) {
            self.failedBlock();
        }
    }
}


@end
