//
//  CLKViewController.m
//  ClockFace
//
//  Created by Alastair Tse on 29/11/2013.
//  Copyright (c) 2013 Alastair Tse. All rights reserved.
//

#import "CLKViewController.h"
#import "CLKFaceView.h"
#import "CLKCircleClockFaceView.h"
#import "CLKDialsClockFaceView.h"
#import "CLKDigitClockFaceView.h"

@interface CLKViewController ()

@end

@implementation CLKViewController {
  CLKFaceView *_faceView;
  UITapGestureRecognizer *_tapper;
  __weak NSTimer *_clockTimer;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor blackColor];
  _faceView = [[CLKFaceView alloc] initWithFrame:self.view.bounds];
  _faceView.clockView = [[CLKDialsClockFaceView alloc] initWithFrame:_faceView.bounds];
  [self.view addSubview:_faceView];

  _tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
  [self.view addGestureRecognizer:_tapper];

  _clockTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(clockTick:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)dealloc {
  [_clockTimer invalidate];
}

- (void)clockTick:(NSTimer *)timer {
  [_faceView.clockView setNeedsLayout];
}

- (void)tap:(UITapGestureRecognizer *)recognizer {
  if (recognizer.state == UIGestureRecognizerStateRecognized) {
    if ([_faceView.clockView isKindOfClass:[CLKCircleClockFaceView class]]) {
      _faceView.clockView = [[CLKDialsClockFaceView alloc] initWithFrame:_faceView.bounds];
    } else if ([_faceView.clockView isKindOfClass:[CLKDialsClockFaceView class]]) {
      _faceView.clockView = [[CLKDigitClockFaceView alloc] initWithFrame:_faceView.bounds];
    } else if ([_faceView.clockView isKindOfClass:[CLKDigitClockFaceView class]]) {
      _faceView.clockView = [[CLKCircleClockFaceView alloc] initWithFrame:_faceView.bounds];

    }
  }
}

@end
