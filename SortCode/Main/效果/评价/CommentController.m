//
//  CommentController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/28.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "CommentController.h"

@interface CommentController ()
// 显示星星视图
@property (nonatomic, strong)UIView * myview;
// 显示图片数组
@property (nonatomic, strong)NSMutableArray * myImageArray;
// 显示分数
@property (nonatomic, strong)UILabel * score;
@end

@implementation CommentController

- (NSMutableArray *)myImageArray{
    if(!_myImageArray){
        _myImageArray = [NSMutableArray array];
        
    }
    return _myImageArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"滑动评价";
    
    _myview = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 180, 24)];
    
    UIImageView *imageView;
    for (int i = 0; i < 5; i++) {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not_selected_star"]];
        imageView.userInteractionEnabled=YES;
        imageView.frame = CGRectMake((i+1)*24, 0, 24, 24);
        [self.myview addSubview:imageView];
        [self.myImageArray addObject:imageView];
    }
    
    
    self.score = [[UILabel alloc] initWithFrame:(CGRectMake(6 * 24 + 5, 0, 40, 24))];
    _score.textColor = [UIColor redColor];
    [self.myview addSubview:_score];
    [self.view addSubview:_myview];
    // Do any additional setup after loading the view.
}




#pragma mark -- 点击的坐标
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self handleTouches:touches];
    
}


#pragma mark - 滑动的坐标
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self handleTouches:touches];
}




- (void)handleTouches:(NSSet *)touches{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:_myview];
    UIImageView *im;
    
    for(int i = 0;i < 5 ; i++){
        im = _myImageArray[i];
        
        NSLog(@"_myImageArray[%i] = (%f,%f)",i,im.frame.origin.x,im.frame.origin.y);
        
        //触摸点
        if ((touchPoint.x > 0)&&(touchPoint.x < 144)&&(touchPoint.y > 0)&&(touchPoint.y < 24)) {
            NSString *myscore = [NSString stringWithFormat:@"%i分",((int)touchPoint.x/24 )];
            _score.text = myscore;//_score是一个UILable，myscore为分数，显示在给用户看，关于这个不在赘述
            if (im.frame.origin.x > touchPoint.x) {
                im.image =[UIImage imageNamed:@"not_selected_star"];
            }else{
                im.image =[UIImage imageNamed:@"selected_star"];
            }
        }
    }
    
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
