//
//  CLKDialsClockFaceView.m
//  ClockFace
//
//  Created by Alastair Tse on 29/11/2013.
//  Copyright (c) 2013 Alastair Tse. All rights reserved.
//

#import "CLKDialsClockFaceView.h"
#import "CLKClock.h"

@implementation CLKDialsClockFaceView {
  CLKClock *_clock;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _clock = [[CLKClock alloc] init];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGSize dialSize = {36, 36};
  CGPoint padding = {14, 6};
  CGPoint dialSeparator = {6, 4};

  NSInteger hour = [_clock hour];
  NSInteger minute = [_clock minute];
  NSInteger hour12 = hour % 12;
  const int kRows = 4;
  const int kCols = 3;

  for (int row = 0; row < kRows; row++) {
    for (int col = 0; col < kCols; col++) {
      UIGraphicsPushContext(context);
      {
        CGPoint dialOrigin = CGPointMake(padding.x + col * dialSize.height + col * dialSeparator.x,
                                         padding.y + row * dialSize.width + row * dialSeparator.y);
        CGRect dialRect = {dialOrigin, dialSize};
        int dialHour = row * kCols + col;

        if (dialHour < hour12) {
          [[UIColor whiteColor] setFill];
          [[UIColor whiteColor] setStroke];
          CGContextFillEllipseInRect(context, dialRect);
          CGContextStrokeEllipseInRect(context, dialRect);
        } else if (dialHour == hour12){
          [[UIColor whiteColor] setFill];
          [[UIColor whiteColor] setStroke];

          CGMutablePathRef pie = CGPathCreateMutable();
          {
            CGPathMoveToPoint(pie, 0, CGRectGetMidX(dialRect), CGRectGetMidY(dialRect));  // center
            CGPathAddLineToPoint(pie, 0, CGRectGetMidX(dialRect), CGRectGetMinY(dialRect));  // 0-minutes
            CGFloat angle = ((double)minute / 60.0) * M_PI * 2;
            CGPathAddArc(pie, 0, CGRectGetMidX(dialRect), CGRectGetMidY(dialRect), dialSize.width / 2, -M_PI_2, angle - M_PI_2, 0);  // draw number of minutes
            CGPathAddLineToPoint(pie, 0, CGRectGetMidX(dialRect), CGRectGetMidY(dialRect));  // back to center.
          }
          CGPathCloseSubpath(pie);
          CGContextAddPath(context, pie);
          CGContextFillPath(context);
          CGPathRelease(pie);

          [[UIColor whiteColor] setStroke];
          CGContextStrokeEllipseInRect(context, dialRect);
        } else {
          [[UIColor whiteColor] setStroke];
          [[UIColor blackColor] setFill];
          CGContextFillEllipseInRect(context, dialRect);
          CGContextStrokeEllipseInRect(context, dialRect);
        }
      }
      UIGraphicsPopContext();
    }
  }
}


@end
