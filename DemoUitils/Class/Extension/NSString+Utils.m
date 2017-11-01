//
//  NSString+Utils.m
//  DemoUitils
//
//  Created by kim on 28/10/2017.
//  Copyright © 2017 kim. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)
//返回汉字拼音
- (NSString *)pinyin{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
