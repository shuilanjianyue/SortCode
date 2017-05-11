

#import <UIKit/UIKit.h>

@interface CustomToastView : UIView
{
    float duration;
}

//提示信息
- (id)initWithView:(UIView*)view text:(NSString*)text duration:(float)inDuration;


- (void)show;


//显示进度  ,不设置时间  有网络请求 ，就会显示
- (id)initWithIndicatorWithView:(UIView *)view withText:(NSString *)text;

//开始显示
- (void)startTheView;

//停止转动，不显示
- (void)stopAndRemoveFromSuperView;

@end
