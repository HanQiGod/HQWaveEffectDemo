//
//  ViewController.m
//  HQWaveEffectDemo
//
//  Created by Mr_Han on 2018/11/21.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (strong, nonatomic) UIBezierPath *path;
@property (strong, nonatomic) CAShapeLayer *shapeLayer2;
@property (strong, nonatomic) UIBezierPath *path2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(0, 100, 375, 150);
    [self.view.layer addSublayer:_shapeLayer];
    
    
    _shapeLayer2 = [CAShapeLayer layer];
    _shapeLayer2.frame = CGRectMake(0, 100, 375, 150);
    [self.view.layer addSublayer:_shapeLayer2];
    
    
    _shapeLayer.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3].CGColor;
    _shapeLayer2.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.3].CGColor;
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawPath)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)drawPath {
    
    static double i = 0;
    
    CGFloat A = 10.f;//A振幅
    CGFloat k = 0;//y轴偏移
    CGFloat ω = 0.03;//角速度ω变大，则波形在X轴上收缩（波形变紧密）；角速度ω变小，则波形在X轴上延展（波形变稀疏）。不等于0
    CGFloat φ = 0 + i;//初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
    
    //y=Asin(ωx+φ)+k
    
    _path = [UIBezierPath bezierPath];
    _path2 = [UIBezierPath bezierPath];
    
    [_path moveToPoint:CGPointZero];
    [_path2 moveToPoint:CGPointZero];
    for (int i = 0; i < 376; i ++) {
        
        CGFloat x = i;
        
        CGFloat y = A * sin(ω*x+φ)+k;
        CGFloat y2 = A * cos(ω*x+φ)+k;
        [_path addLineToPoint:CGPointMake(x, y)];
        [_path2 addLineToPoint:CGPointMake(x, y2)];
        
    }
    [_path addLineToPoint:CGPointMake(375, -100)];
    [_path addLineToPoint:CGPointMake(0, -100)];
    _path.lineWidth = 1;
    _shapeLayer.path = _path.CGPath;
    
    [_path2 addLineToPoint:CGPointMake(375, -100)];
    [_path2 addLineToPoint:CGPointMake(0, -100)];
    _path2.lineWidth = 1;
    
    _shapeLayer2.path = _path2.CGPath;
    
    
    
    i += 0.1;
    
    if (i > M_PI * 2) {
        
        i = 0;//防止i越界
        
    }
    
}

@end
