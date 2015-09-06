//
//  CLKFontDumper.h
//  ClockFace
//
//  Created by Alastair Tse on 30/11/2013.
//  Copyright (c) 2013 Alastair Tse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLKFontDumper : NSObject

+ (void)outputRasterizedFontWithCharacters:(NSString *)characters
                                  withFont:(UIFont *)font
                           outputDirectory:(NSString *)directory;

@end
