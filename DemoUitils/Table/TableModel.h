//
//  TableModel.h
//  DemoUitils
//
//  Created by kim on 28/10/2017.
//  Copyright © 2017 kim. All rights reserved.
//

#ifndef TableModel_h
#define TableModel_h


#endif /* TableModel_h */
#import<Foundation/Foundation.h>
//@class SectionModel;

@interface TableModel:NSObject
@property(nonatomic)NSNumber *phoneNumber;
@property(nonatomic,strong)NSString *emailLink;
@property(nonatomic,strong)NSString *Area;
@property(nonatomic)NSNumber *homeNumber;
@property(nonatomic)BOOL isOpen;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *portrait;//头像
@property(nonatomic,strong)NSString *pinyin;
@property(nonatomic,assign)BOOL isSectionTitleData;
@end
/*
@interface SectionModel:NSObject
@property(nonatomic,strong)NSArray *ListBysectionArr;
@property(nonatomic,strong)NSArray *ListByDataArr;
@property(nonatomic,assign)BOOL isSectionTitleData;
@end
*/
