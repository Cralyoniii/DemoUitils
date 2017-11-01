//
//  TableModel.m
//  DemoUitils
//
//  Created by kim on 28/10/2017.
//  Copyright © 2017 kim. All rights reserved.
//

#import "TableModel.h"
#import "NSString+Utils.h"
@implementation TableModel
-(void)setName:(NSString *)name{
    if(name){
        _name=name;
        _pinyin=_name.pinyin;
    }
}
@end
