//
//  ContactDataHelper.m
//  DemoUitils
//
//  Created by kim on 28/10/2017.
//  Copyright © 2017 kim. All rights reserved.
//

#import "ContactDataHelper.h"
#import "TableModel.h"
@implementation ContactDataHelper
+(NSMutableArray *)getFriendListDataBy:(NSMutableArray *)array{
    NSMutableArray *ans=[[NSMutableArray alloc]init];
    NSArray *serializeArray=[(NSArray *)array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int i;
        NSString *strA=((TableModel *)obj1).pinyin;
        NSString *strB=((TableModel *)obj2).pinyin;
        for(i=0;i<strA.length&&i<strB.length;i ++){
            char a=[strA characterAtIndex:i];
            char b=[strB characterAtIndex:i];
            if(a>b){
                return (NSComparisonResult)NSOrderedDescending;
            }else if(a<b){
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        if(strA.length>strB.length){
                return (NSComparisonResult)NSOrderedDescending;
        }else if(strA.length<strB.length){
                return (NSComparisonResult)NSOrderedAscending;
        }else{
                return (NSComparisonResult)NSOrderedSame;
        }
        
    }];
    char lastC='1';
    NSMutableArray *data;
    NSMutableArray *oth=[[NSMutableArray alloc]init];
    for(TableModel *user in serializeArray){
        char c=[user.pinyin characterAtIndex:0];
        if(!isalpha(c)){
            [oth addObject:user];
        }else if (c!=lastC){
            lastC=c;
            if(data && data.count>0){
                [ans addObject:data];
            }
            data=[[NSMutableArray alloc]init];
            [data addObject:user];
        }else{
            [data addObject:user];
        }
    }
    if(oth.count>0){
        [ans addObject:oth];
    }
    return ans;
    
}
+(NSMutableArray*)getFriendListSectionBy:(NSMutableArray *)array{
    NSMutableArray *section=[[NSMutableArray alloc]init];
    [section addObject:UITableViewIndexSearch];
    for (NSArray *item in array) {
        TableModel *user=[item objectAtIndex:0];
        char c=[user.pinyin characterAtIndex:0];
        if(!isalpha(c)){
            c='#';
        }
        [section addObject:[NSString stringWithFormat:@"%c",toupper(c)]];
    }
    return section;
}
@end
