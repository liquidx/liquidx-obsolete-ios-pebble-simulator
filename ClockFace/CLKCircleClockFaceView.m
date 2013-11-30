//
//  CLKCircleFaceView.m
//  ClockFace
//
//  Created by Alastair Tse on 29/11/2013.
//  Copyright (c) 2013 Alastair Tse. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <CoreMotion/CoreMotion.h>

#import "CLKCircleClockFaceView.h"
#import "CLKClock.h"

@interface CLKCircleView : UIView
@end

@implementation CLKCircleView
- (void)drawRect:(CGRect)rect {
  CGRect bounds = self.bounds;
  CGContextRef context = UIGraphicsGetCurrentContext();
  UIGraphicsPushContext(context);
  {
    [[UIColor whiteColor] setFill];
    [[UIColor clearColor] setStroke];
    CGContextFillEllipseInRect(context, bounds);

//    [[UIColor blackColor] setFill];
//    CGRect north = bounds;
//    north.size = CGSizeMake(4, 4);
//    north.origin.x = floor((bounds.size.width - north.size.width) / 2);
//    CGContextFillEllipseInRect(context, north);
  }
  UIGraphicsPopContext();
}@end

@implementation CLKCircleClockFaceView {
  UILabel *_label;
  UIView *_containerView;
  CLKCircleView *_circleView;
  CLKClock *_clock;
  CMMotionManager *_motionManager;

  // Low pass filtering
  CGFloat _lastX;
  CGFloat _lastY;
  NSTimeInterval _dt;
  CGFloat _rc;
  CGFloat _alpha;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _clock = [[CLKClock alloc] init];

    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    _containerView.autoresizesSubviews = YES;
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.opaque = YES;
    _containerView.layer.shouldRasterize = YES;
    _containerView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    [self addSubview:_containerView];

    _circleView = [[CLKCircleView alloc] initWithFrame:CGRectZero];
    _circleView.backgroundColor = [UIColor clearColor];
    [_containerView addSubview:_circleView];

    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    _label.font = [UIFont fontWithName:@"DINCondensed-Bold" size:64];
    _label.textColor = [UIColor blackColor];
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = [_clock timeString];
    [_containerView addSubview:_label];

    // Set up low pass filter
    _lastX = 0;
    _lastY = 0;
    _dt = 0.1;  // 1 / fps
    _rc = 0.25;
    _alpha = _dt / (_rc + _dt);

    self.backgroundColor = [UIColor blackColor];
    self.opaque = NO;

    _motionManager = [[CMMotionManager alloc] init];
    CLKCircleClockFaceView * __weak weakSelf = self;
    if ([_motionManager isAccelerometerAvailable]) {
      [_motionManager setAccelerometerUpdateInterval:_dt];
      [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                           withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                             [weakSelf rotateLayerByAccelerometerData:accelerometerData];
                                           }];
    }
  }
  return self;
}

- (void)dealloc {
  [_motionManager stopAccelerometerUpdates];
}

- (void)rotateLayerByAccelerometerData:(CMAccelerometerData *)accelerometerData {
  CGFloat angle = 0;
  if (accelerometerData.acceleration.z > -0.95) {
    CGFloat x = accelerometerData.acceleration.x;
    CGFloat y = accelerometerData.acceleration.y;

    CGFloat smoothedX = (_alpha * x) + (1.0 - _alpha) * _lastX;
    CGFloat smoothedY = (_alpha * y) + (1.0 - _alpha) * _lastY;

    angle = atan2(smoothedY, smoothedX) + M_PI_2;
    _lastX = smoothedX;
    _lastY = smoothedY;
  }
  CATransform3D transform = CATransform3DIdentity;
  transform = CATransform3DRotate(transform, -angle, 0, 0, 1);
  _containerView.layer.transform = transform;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CATransform3D origTransform;
  CGRect circleRect = self.bounds;
  circleRect.origin.y += floor((circleRect.size.height - circleRect.size.width) / 2);
  circleRect.size.height = circleRect.size.width;
  circleRect = CGRectInset(circleRect, 4, 4);

  origTransform = _circleView.layer.transform;
  _circleView.layer.transform = CATransform3DIdentity;
  _circleView.frame = circleRect;
  _circleView.layer.transform = origTransform;

  CGRect faceFrame = self.bounds;
  CGRect labelFrame = faceFrame;
  CGFloat kTextHeight = 64;
  labelFrame.origin.y += floor((faceFrame.size.height - kTextHeight) / 2) + floor(kTextHeight / 8);
  labelFrame.size.height = kTextHeight;

  origTransform = _label.layer.transform;
  _label.layer.transform = CATransform3DIdentity;
  _label.frame = labelFrame;
  _label.text = [_clock timeString];
  _label.layer.transform = origTransform;
}



@end
