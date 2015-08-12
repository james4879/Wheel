//
//  ViewController.m
//  Wheel
//
//  Created by James Hsu on 8/11/15.
//  Copyright (c) 2015 James Hsu. All rights reserved.
//

#import "ViewController.h"

#import "OBShapedButton.h"
#import "ButtonMenu.h"

@interface ViewController ()

@property (nonatomic, weak) UIImageView *circleImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加背景图片
    [self addBackgroundImage];
    
    // 添加三个按钮
    [self addThreeButton];
    
    // 添加中心按钮
    [self addCenterButton];
    
    // 添加底部按钮
    [self addButtonMenu];
}

/**
 *  添加底部按钮
 */
- (void)addButtonMenu
{
    ButtonMenu *menu = [ButtonMenu buttonMenu];
    CGFloat menuX = 0;
    CGFloat menuY = self.view.bounds.size.height - menu.bounds.size.height;
    CGFloat menuW = self.view.bounds.size.width;
    CGFloat menuH = menu.bounds.size.height;
    menu.frame = CGRectMake(menuX, menuY, menuW, menuH);
    
    [self.view addSubview:menu];
}

/**
 *  点击中心按钮
 *
 *  @param button 中心按钮
 */
- (void)centerButtonClick:(UIButton *)button
{
    CGFloat currentAlpha = self.circleImageView.alpha;
    // 先实现隐藏和显示
    if (currentAlpha == 1) {
        self.circleImageView.alpha = 0;
    } else {
        self.circleImageView.alpha = 1;
    }
    // 组动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    // 透明度
    CABasicAnimation *opacityAnimation = [CABasicAnimation animation];
    opacityAnimation.keyPath = @"opacity";
    // 缩放
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    // 旋转
    CABasicAnimation *rotateAnimation = [CABasicAnimation animation];
    rotateAnimation.keyPath = @"transform.rotation";
    
    // 如果是要隐藏，透明度是由“显示“到”消失“
    if (currentAlpha == 1) {
        opacityAnimation.fromValue = @1;
        opacityAnimation.toValue = @0;
        scaleAnimation.values = @[@1, @1.2, @0];
        rotateAnimation.fromValue = @0;
        rotateAnimation.toValue = @(-M_PI_4);
    } else {
        opacityAnimation.fromValue = @0;
        opacityAnimation.toValue = @1;
        scaleAnimation.values = @[@0, @1.2, @1];
        rotateAnimation.fromValue = @(-M_PI_4);
        rotateAnimation.toValue = @0;
    }
    animationGroup.animations = @[opacityAnimation, scaleAnimation, rotateAnimation];
    animationGroup.duration = 1.0f;
    [self.circleImageView.layer addAnimation:animationGroup forKey:nil];
}

/**
 *  添加中心按钮
 */
- (void)addCenterButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.center = self.circleImageView.center;
    [button setBackgroundImage:[UIImage imageNamed:@"home_btn_dealer_had_bind"] forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, 112, 112);
    [button addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

/**
 *  点击按钮
 *
 *  @param button 选择点击的按钮
 */
- (void)buttonClick:(UIButton *)button
{
    NSLog(@"%ld", button.tag);
}

/**
 *  添加三个按钮
 */
- (void)addThreeButton
{
    for (NSInteger index = 0; index < 3; index++) {
        NSString *imageName = [NSString stringWithFormat:@"circle%ld", index + 1];
        UIButton *button = [OBShapedButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.circleImageView.bounds;
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        button.tag = index;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.circleImageView addSubview:button];
    }
}

/**
 *  添加背景图片
 */
- (void)addBackgroundImage
{
    UIImageView *circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_yuanpan_bg"]];
    circleImageView.frame = CGRectMake(self.view.frame.size.width * 0.5 - 153, self.view.frame.size.height * 0.5 - 153, 306, 306);
    self.circleImageView = circleImageView;
    self.circleImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.circleImageView];
}

@end
