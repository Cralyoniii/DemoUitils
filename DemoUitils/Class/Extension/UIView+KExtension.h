//
//  UIView+KExtension.h
//  DemoUitils
//
//  Created by kim on 28/10/2017.
//  Copyright © 2017 kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KExtension)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGPoint origin;

+ (NSString *)reuseIdentifier;
@end
