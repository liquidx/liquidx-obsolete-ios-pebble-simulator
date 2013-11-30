//
//  CLKClock.m
//  ClockFace
//
//  Created by Alastair Tse on 29/11/2013.
//  Copyright (c) 2013 Alastair Tse. All rights reserved.
//

#import "CLKClock.h"

@implementation CLKClock

- (NSString *)timeString {
  return [NSString stringWithFormat:@"%02ld%02ld", (long)[self hour], (long)[self minute]];
}

- (NSInteger)hour {
  NSDate *now = [NSDate date];
  NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitMinute;
  NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:now];
  return components.hour;
}

- (NSInteger)minute {
  NSDate *now = [NSDate date];
  NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitMinute;
  NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:now];
  return components.minute;
}


@end
