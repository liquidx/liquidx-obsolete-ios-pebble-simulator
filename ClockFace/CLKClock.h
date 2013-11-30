//
//  CLKClock.h
//  ClockFace
//
//  Created by Alastair Tse on 29/11/2013.
//  Copyright (c) 2013 Alastair Tse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLKClock : NSObject

- (NSString *)timeString;

- (NSInteger)hour;
- (NSInteger)minute;

@end
