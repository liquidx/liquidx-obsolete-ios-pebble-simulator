//
//  CLKFontDumper.m
//  ClockFace
//
//  Created by Alastair Tse on 30/11/2013.
//  Copyright (c) 2013 Alastair Tse. All rights reserved.
//

#import "CLKFontDumper.h"

@implementation CLKFontDumper

+ (void)outputRasterizedFontWithCharacters:(NSString *)characters
                                  withFont:(UIFont *)font
                           outputDirectory:(NSString *)directory {

  NSDictionary *attributes = @{
    NSFontAttributeName: font,
    NSForegroundColorAttributeName: [UIColor blackColor],
    NSBackgroundColorAttributeName: [UIColor whiteColor],
  };

  for (NSInteger i = 0; i < [characters length]; ++i) {
    NSString *characterString = [characters substringWithRange:NSMakeRange(i, 1)];
    CGSize characterSize = [characters sizeWithAttributes:attributes];

    UIGraphicsBeginImageContextWithOptions(characterSize, NO, 1);
    [characterString drawAtPoint:CGPointMake(0, 0) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    NSData *pngData = UIImagePNGRepresentation(image);
    NSString *filename = [[directory stringByAppendingPathComponent:characterString] stringByAppendingPathExtension:@"png"];
    [pngData writeToFile:filename atomically:YES];
    NSLog(@"filename: %@", filename);
    UIGraphicsEndImageContext();
  }
}


@end
