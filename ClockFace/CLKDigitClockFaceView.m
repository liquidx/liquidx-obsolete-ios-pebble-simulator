//
//  CLKDigitClockFaceView.m
//  ClockFace
//
//  Created by Alastair Tse on 29/11/2013.
//  Copyright (c) 2013 Alastair Tse. All rights reserved.
//

#import "CLKDigitClockFaceView.h"
#import "CLKClock.h"

@implementation CLKDigitClockFaceView {
  UILabel *_label;
  CLKClock *_clock;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _clock = [[CLKClock alloc] init];
//    _label = [[UILabel alloc] initWithFrame:CGRectZero];
//    _label.font = [UIFont fontWithName:@"DINCondensed-Bold" size:120];
//    _label.textColor = [UIColor whiteColor];
//    _label.backgroundColor = [UIColor clearColor];
//    _label.textAlignment = NSTextAlignmentCenter;
//    _label.contentMode = UIViewContentModeCenter;
//    _label.text = @"1";
//
//    [self addSubview:_label];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _label.frame = self.bounds;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();


  CGFloat fraction = (double)[_clock minute] / 60.0;
  CGSize size = self.bounds.size;
  CGRect fillRect = CGRectMake(0, floor((1.0 - fraction) * size.height), size.width, ceil(size.height * fraction));

  UIGraphicsPushContext(context);
  [[UIColor whiteColor] setFill];
  CGContextFillRect(context, fillRect);
  UIGraphicsPopContext();

  UIGraphicsPushContext(context);

  // Invert text drawing.
  CGRect viewBounds = self.bounds;
  CGContextTranslateCTM(context, 0, viewBounds.size.height);
  CGContextScaleCTM(context, 1, -1);

  [[UIColor whiteColor] setFill];
  CGContextSelectFont (context, "DINCondensed-Bold", 120, kCGEncodingMacRoman);
  //CGContextSetCharacterSpacing (context, 10); // 4
  CGContextSetTextDrawingMode(context, kCGTextFillStroke);
  NSInteger hour12 = [_clock hour] % 12;
  NSString *hourString = [NSString stringWithFormat:@"%ld", (long)hour12];
  CGContextSetBlendMode(context, kCGBlendModeExclusion);
  CGContextShowTextAtPoint(context, 40, 40, [hourString cStringUsingEncoding:NSUTF8StringEncoding], 2);
  UIGraphicsPopContext();
}

@end
