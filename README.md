# WWScrollViewCapture#
保存UIScrollView内容截图
## 调用方法
<p> <code>- (instancetype) initWithPoint:(CGPoint)point scollView:(UIScrollView *)scrollView succeed:(SavingSucceedBlock)succeedBlock failed:(SavingFaidedBlock)failedBlock;</code> </p>
两个Block分别是保存成功或者失败的处理
### 保存前
![image](https://raw.githubusercontent.com/WilliamZhangWH/WWScrollViewCapture/master/screenshot/capture_unsaved.png)
### 保存后
![image](https://raw.githubusercontent.com/WilliamZhangWH/WWScrollViewCapture/master/screenshot/capture_saved.png)
