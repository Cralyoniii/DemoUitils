//
//  PublicClass.h
//  DemoUitils
//
//  Created by kim on 28/10/2017.
//  Copyright © 2017 kim. All rights reserved.
//

#ifndef PublicClass_h
#define PublicClass_h


#endif /* PublicClass_h */
/** 16进制转RGB*/
#define HEX_COLOR(x_RGB) [UIColor colorWithRed:((float)((x_RGB & 0xFF0000) >> 16))/255.0 green:((float)((x_RGB & 0xFF00) >> 8))/255.0 blue:((float)(x_RGB & 0xFF))/255.0 alpha:1.0f]
#define VIEWWIDTH               [UIScreen mainScreen].bounds.size.width
#define VIEWHEIGHT              [UIScreen mainScreen].bounds.size.height
