//
//  CLKFaceView.m
//  ClockFace
//
//  Created by Alastair Tse on 29/11/2013.
//  Copyright (c) 2013 Alastair Tse. All rights reserved.
//

#import "CLKFaceView.h"

const CGSize faceSize = {144, 168};

@implementation CLKFaceView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor blackColor];
  }
  return self;
}


- (CGRect)faceFrameForBounds:(CGRect)bounds {
  return CGRectInset(bounds,
                     ceil((bounds.size.width - faceSize.width) / 2),
                     ceil((bounds.size.height - faceSize.height) / 2));
}

- (void)setClockView:(UIView *)clockView {
  [_clockView removeFromSuperview];
  _clockView = clockView;
  if (_clockView ) {
    _clockView.frame = [self faceFrameForBounds:self.bounds];
    [self addSubview:_clockView];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _clockView.frame = [self faceFrameForBounds:self.bounds];
}

- (void)drawRect:(CGRect)rect {
  CGRect faceFrame = [self faceFrameForBounds:self.bounds];
  CGContextRef context = UIGraphicsGetCurrentContext();
  UIGraphicsPushContext(context);
  {
    [[UIColor colorWithWhite:0.3 alpha:1.0] setStroke];
    CGContextStrokeRect(context, faceFrame);
  }
  UIGraphicsPopContext();
}


@end
