//
//  CLKFaceView.h
//  ClockFace
//
//  Created by Alastair Tse on 29/11/2013.
//  Copyright (c) 2013 Alastair Tse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLKFaceView : UIView

// Actual contents of the clock face.
@property(nonatomic, strong) UIView *clockView;

- (CGRect)faceFrameForBounds:(CGRect)bounds;

@end

