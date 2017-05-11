

#import "CustomToastView.h"

@implementation CustomToastView

#define minWidth    120
#define maxWidth    SCREEN_WIDTH-40
#define toastheight 50

{
    UIActivityIndicatorView *activity;
    //添加一个透明的View
    UIView *_view;
    
    NSTimer *timer;
    
}


- (id)initWithIndicatorWithView:(UIView *)view withText:(NSString *)text
{//另外一个控制器的view
    
    int width = 90;
    
    NSDictionary *arrtribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    
    CGSize size=[text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, 50000000) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:arrtribute context:nil].size;
    
    
    if (size.width > width-20) {
        
        if (size.width < maxWidth-20) {
            
            width = size.width+20;
            
        }
        else {
            
            width = maxWidth;
        }
    }
    
    
    CGRect rect = CGRectMake((SCREEN_WIDTH-width)/2, (SCREEN_HEIGHT-64-90)/2, width, 90);
    self = [super  initWithFrame:rect];
    //设置中心点
   // [self setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    
    if (self) {
        
        self.layer.cornerRadius = 6;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        self.alpha = 0;
        
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _view.backgroundColor = [UIColor clearColor];
        
        
        //添加指示器
        activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
        [activity setCenter:CGPointMake(self.frame.size.width/2, 30)];
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:activity];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, width, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:13];
        label.text =text;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:label];
        
        [_view addSubview:self];
        [view addSubview:_view];
        
        //只是隐藏
        _view.hidden = YES;
        
    }
    return self;
}



- (void)startTheView
{
    _view.hidden = NO;
    [activity startAnimating];
    
    
    [UIView animateWithDuration:0.3 animations:^{
//                _view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        self.alpha = 1;
    }];
}




- (void)stopAndRemoveFromSuperView
{
    [activity stopAnimating];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        _view.hidden = YES;
        [self removeFromSuperview];
        
    }];
    
    
    
}


#pragma mark  普通提示

- (id)initWithView:(UIView*)view text:(NSString*)text duration:(float)inDuration
{
    //显示的时间
    
    int width = minWidth;
    
    NSDictionary *arrtribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    
    CGSize size=[text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, 50000000) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:arrtribute context:nil].size;
    
    
    if (size.width > width-20) {
        
        if (size.width < maxWidth-20) {
            width = size.width+20;
            
        }
        else {
            
            width = maxWidth;
        }
    }
    
    
    CGRect rect = CGRectMake((view.bounds.size.width-width)/2, (view.bounds.size.height-toastheight)/2, width, toastheight);
    
    self = [super initWithFrame:rect];
    
    if (self) {
        
        // Initialization code
        self.layer.cornerRadius = 6;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        self.alpha = 0;
        
        duration = inDuration;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.bounds.size.width-20, toastheight-20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.text = text;
        [self addSubview:label];
        
        [view addSubview:self];
        
        
    }
    
    return self;
}


- (void)show {
    
    [activity startAnimating];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
    
    
    [self performSelector:@selector(closeToast) withObject:nil afterDelay:duration];
    
//    //显示的时间
//    timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(closeToast) userInfo:nil repeats:NO];
//    
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


- (void)closeToast{
    [activity stopAnimating];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


-(void)dealloc{

    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
