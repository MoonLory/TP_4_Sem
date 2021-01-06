//
//  ViewController.m
//  task2-1
//
//  Created by Admin on 06/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property CGPoint lastPoint;

@property CGFloat lineWidth;
@property (weak, nonatomic) IBOutlet UISlider *widthSlider;

@property CGFloat green;
@property CGFloat blue;
@property CGFloat red;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _green = 0.f;
    _blue = 0.f;
    _red = 0.f;
    
    _lineWidth = 5.f;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self setLastPoint:[touch locationInView:self.view]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width,
                                 self.view.frame.size.height);
    [[[self imageView] image] drawInRect:drawRect];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _lineWidth);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _red, _green, _blue, 1.0f);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x,
                         _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x,
                            currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    [[self imageView] setImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    _lastPoint = currentPoint;
}

- (IBAction)changeColorToBlue:(id)sender {
    _green = 0.f;
    _blue = 1.f;
    _red = 0.f;
}

- (IBAction)changeColorToGreen:(id)sender {
    _green = 1.f;
    _blue = 0.f;
    _red = 0.f;
}

- (IBAction)changeColorToRed:(id)sender {
    _green = 0.f;
    _blue = 0.f;
    _red = 1.f;
}

- (IBAction)changeColorToYellow:(id)sender {
    _green = 1.f;
    _blue = 0.f;
    _red = 1.f;
}

- (IBAction)changeColorToBlack:(id)sender {
    _green = 0.f;
    _blue = 0.f;
    _red = 0.f;
}

- (IBAction)changeWidth:(id)sender {
    _lineWidth = _widthSlider.value * 25;
}

- (IBAction)saveImage:(id)sender {
    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, nil, nil);
}

@end
