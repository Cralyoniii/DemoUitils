//
//  ViewController.m
//  DemoUitils
//
//  Created by kim on 28/10/2017.
//  Copyright © 2017 kim. All rights reserved.
//
/*------------------最方便的当然是tableModel的数据类型中添加个字段，isOpen啦----------------*/
/*
 isopen :第一次进入页面使用，在未刷新，未点击展开按钮，未离开页面时，保持yes状态
 */
/*--------------------------------end-----------------------------------------*/
#import "ViewController.h"
#import "TableModel.h"
#import "ContactDataHelper.h"//格式化通讯录数组
#import "webView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
@property(nonatomic,strong)UITableView *testTable;
@property(nonatomic,strong)NSArray *indexArr;//首字母下标组成的数组
@property(nonatomic,assign)BOOL isopen;//用于第一次进入页面使用，以后未离开页面并且为重新加载页面open一直为yes
@property(nonatomic,assign)NSInteger selectIndex;//点击的section值
@property(nonatomic,assign)BOOL isReloadtoClose;//记录上一次点击的section是否关闭
@property(nonatomic,strong)NSMutableArray <TableModel*>*resultArr;//最终形成的Section列表数据
@property(nonatomic,strong)NSMutableDictionary *sectionDic;//记录快速搜索的首字母的section index值

@property(nonatomic,strong)NSMutableArray *searchArr;
@property(nonatomic,strong)NSMutableArray <TableModel*>*searchResultArr;
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UISearchController *searchController;

@property(nonatomic,strong)NSArray *nameArr;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _searchArr=[NSMutableArray array];
    _selectIndex=-1;
    _isopen=NO;
    _isReloadtoClose=NO;
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *arr=[NSArray array];
    _nameArr=[NSArray array];
    _resultArr=[NSMutableArray array];
    _searchResultArr=[NSMutableArray array];
    _sectionDic=[NSMutableDictionary dictionaryWithCapacity:10];
    arr=@[@"kim",@"linux",@"Cralyon",@"啦啦adsfa阿拉",@"你sdasd是",@"%^_^QAQ",@"linux",@"Cralyon",@"啦啦阿拉",@"你是",@"%^_^QAQ",@"34524312",@"asddddfasdfa",@"llljjj",@"23341",@"kim",@"linux",@"Cralyon",@"啦啦阿拉",@"你是",@"%^_^QAaaaaQ",@"ladfasinux",@"Craldasfyon",@"啦啦阿拉",@"oo你啊是",@"%^_^QAQaaaaqqa",@"ada3452adfa4312",@"asdfasdfa",@"jjj",@"23341",@"东方不败",@"人类",@"地球人",@"中国人",@"山顶洞人",@"蓝田人"];
    _nameArr=arr;
    [self configureView:arr];
}
-(void)configureSearchView{
    _searchController=[[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater=self;
    _searchController.dimsBackgroundDuringPresentation=NO;//默认yes，控制搜索控制器的灰色半透明效果
    //_searchController.hidesNavigationBarDuringPresentation=NO;//默认yes，控制搜索时是否隐藏导航栏
    _searchController.searchBar.delegate=self;
    _searchController.searchBar.placeholder=@"请输入关键字";
    _searchController.searchBar.tintColor=[UIColor blackColor];
    _searchController.searchBar.barTintColor=[UIColor whiteColor];
    [_searchController.searchBar sizeToFit];
    self.definesPresentationContext=YES;
    self.testTable.tableHeaderView=_searchController.searchBar;
}
-(void)configureView:(NSArray *)arr{
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"js交互测试" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick:)];
    self.navigationItem.rightBarButtonItem=rightItem;
    NSMutableArray *nsmuArr=[NSMutableArray array];
    for (int i=0; i<arr.count; i++) {
        TableModel *model=[TableModel new];
        model.phoneNumber=@(1010110011*(i+1));
        model.homeNumber=@(110+i);
        model.Area=@"地球";
        model.emailLink=@"www.1024@kim.com";
        model.name=arr[i];
        //model.isOpen=NO;
        //添加isOpen字段，发现没必要了，原来的基础上添加的控制字段有3个，若model添加isopen字段，则仍需添加2个字段，毫无意义，只是在这个页面少申请了一个bool对象
        [nsmuArr addObject:model];
    };
    NSArray *mArr=[NSArray array];
    mArr=[ContactDataHelper getFriendListDataBy:nsmuArr];
    _indexArr=[NSArray array];
    _indexArr=[ContactDataHelper getFriendListSectionBy:[mArr mutableCopy]];
    //合成一整个
    NSInteger section=0;
    for (int i=1; i<_indexArr.count; i++) {
        TableModel *model=[TableModel new];
        model.isSectionTitleData=YES;
        model.name=_indexArr[i];
        [_resultArr addObject:model];
        int j;
        for (j=0; j<[mArr[i-1] count]; j++) {
            TableModel *model=mArr[i-1][j];
            model.isSectionTitleData=NO;
            [_resultArr addObject:model];
        }
        [_sectionDic setObject:@(section-1) forKey:model.name];
         section+=1+j;
    }
    //NSLog(@"%@",_resultArr);
    self.navigationItem.title=@"Demo";
    self.testTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.testTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    //self.testTable.sectionHeaderHeight=0.01;
    self.testTable.sectionFooterHeight=20.0;
    self.testTable.delegate=self;
    self.testTable.dataSource=self;
    [self.view addSubview:self.testTable];
    //[self.testTable reloadData];
    [self configureSearchView];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.testTable setTableFooterView:v];
    
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [self.searchArr removeAllObjects];
    [self.searchResultArr removeAllObjects];
    NSPredicate *searchPredicate=[NSPredicate predicateWithFormat:@"self contains[cd] %@",_searchController.searchBar.text];
    //self.searchArr=
    self.searchArr=[[_nameArr filteredArrayUsingPredicate:searchPredicate]mutableCopy];
    NSLog(@"222:%@",_searchArr);
    for(TableModel *model in _resultArr){
        if([_searchArr containsObject:model.name]){
            [_searchResultArr addObject:model];
        }
    }
    [self.testTable reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_isopen&&section==self.selectIndex){
        if(self.isReloadtoClose){
            return 0;
        }
        return 4;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_searchController.active){
        return _searchArr.count;
    }
    return _resultArr.count;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(_searchController.active){
        UIView *view=[UIView new];
        view=[self registerHeaderView:section];
        return view;
    }
    if(_resultArr[section].isSectionTitleData){
        
        id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
        if (!label) {
            label = [[UILabel alloc] init];
            [label setFont:[UIFont systemFontOfSize:14.5f]];
            [label setTextColor:[UIColor grayColor]];
            [label setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
        }
        [label setText:[NSString stringWithFormat:@"  %@",_resultArr[section].name]];
        return label;
    }
    UIView *view=[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[UIButton new];
    UILabel *label=[UILabel new];
    //头像什么的在这里加
    //label.userInteractionEnabled=YES;
    label.textAlignment=NSTextAlignmentCenter;
    //UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollLideView:)];
    //[label addGestureRecognizer:tap];
    btn.tag=section;
    /*这里多加一个Button 是为了方便记录点击的Section，目前只知道Button 的click可以传button的标记值，这里设置tag为section*/
    [btn addTarget:self action:@selector(scrollLideView:) forControlEvents:UIControlEventTouchUpInside];
    
    label.text=_resultArr[section].name;
    [view addSubview:label];
    [view addSubview:btn];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.top.and.right.equalTo(view);
    }];
    if(_resultArr.count<section+1){
        return view;
    }
    UIImageView *lineImg=[UIImageView new];
    [lineImg setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
    [view addSubview:lineImg];
    [lineImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(view);
        make.height.equalTo(@1);
    }];
    
    return view;
}
-(UIView*)registerHeaderView:(NSInteger)section{
    UIView *view=[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[UIButton new];
    UILabel *label=[UILabel new];
    //头像什么的在这里加
    //label.userInteractionEnabled=YES;
    label.textAlignment=NSTextAlignmentCenter;
    //UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollLideView:)];
    //[label addGestureRecognizer:tap];
    btn.tag=section;
    /*这里多加一个Button 是为了方便记录点击的Section，目前只知道Button 的click可以传button的标记值，这里设置tag为section*/
    [btn addTarget:self action:@selector(scrollLideView:) forControlEvents:UIControlEventTouchUpInside];
    
    label.text=_searchResultArr[section].name;
    [view addSubview:label];
    [view addSubview:btn];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.top.and.right.equalTo(view);
    }];
    if(_searchResultArr.count<section+1){
        return view;
    }
    UIImageView *lineImg=[UIImageView new];
    [lineImg setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
    [view addSubview:lineImg];
    [lineImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(view);
        make.height.equalTo(@1);
    }];
    return view;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if(_searchController.active){
        return nil;
    }
    return _indexArr;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    //NSInteger i=0;
    //这里需要修复搜索栏定位问题,需要优化，若数据多时，可能出现卡顿，这时候，这种方法就不适合了，最好在一开始就定位searchbar字段的section位置，那么从初始化开始吧
    /*for(TableModel *model in _resultArr){
        if([model.name isEqualToString:title]){
            index=i;
            break;
        }
        i++;
    }*/
    index=[[_sectionDic objectForKey:title] integerValue];
    return index-1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(_searchController.active){
        return 60;
    }
    
    if(_resultArr[section].isSectionTitleData){
        return 30;
    }
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[UITableViewCell new];
    TableModel *model=_resultArr[indexPath.section];
    if(_searchController.active){
        model=_searchResultArr[indexPath.section];
    }
    
    NSArray *arrStr=@[];
    switch (indexPath.row) {
        case 0:
            arrStr=@[[NSString stringWithFormat:@"%@",model.homeNumber],@"家用电话:"];
            break;
        case 1:
            arrStr=@[[NSString stringWithFormat:@"%@",model.phoneNumber],@"手机号码:"];
            break;
        case 2:
            arrStr=@[model.emailLink,@"E-mail:"];
            break;
        case 3:
            arrStr=@[model.Area,@"地区:"];
            break;
        default:
            break;
    }
    UILabel *titleLabel=[UILabel new];
    titleLabel.textAlignment=NSTextAlignmentRight;
    titleLabel.text=arrStr[1];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font=[UIFont systemFontOfSize:13];
    UILabel *detailLabel=[UILabel new];
    detailLabel.textAlignment=NSTextAlignmentCenter;
    detailLabel.font=[UIFont systemFontOfSize:13];
    detailLabel.text=arrStr[0];
    detailLabel.textColor=[UIColor blackColor];
    [cell addSubview:titleLabel];
    [cell addSubview:detailLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell).with.offset(10);
        make.top.and.bottom.equalTo(cell);
        make.width.equalTo(@100);
    }];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right);
        make.right.equalTo(cell);
        make.top.and.bottom.equalTo(cell);
    }];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark-- click
-(void)rightBarClick:(UIBarButtonItem*)item{
    webView *vc=[webView new];
    vc.title=@"test";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)scrollLideView:(UIButton *)sender {
   /* if(sender.tag==1){
        webView *vc=[webView new];
        vc.title=@"test";
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }*/
    if(self.selectIndex==-1){   //第一次进入页面
        self.selectIndex=sender.tag;
        self.isopen=YES;
        self.isReloadtoClose=NO;
        NSIndexSet *addIndexSet=[NSIndexSet indexSetWithIndex:sender.tag];
        [self.testTable reloadSections:addIndexSet withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    if(self.selectIndex!=sender.tag){
        self.isReloadtoClose=YES;
        NSIndexSet *deleteIndexSet=[NSIndexSet indexSetWithIndex:self.selectIndex];
        [self.testTable reloadSections:deleteIndexSet withRowAnimation:UITableViewRowAnimationNone];
        
        self.isReloadtoClose=NO;
        self.selectIndex=sender.tag;
        NSIndexSet *reloadIndexSet=[NSIndexSet indexSetWithIndex:self.selectIndex];
        [self.testTable reloadSections:reloadIndexSet withRowAnimation:UITableViewRowAnimationFade];
    }else{
        if(self.isReloadtoClose){
            self.isReloadtoClose=NO;
            self.selectIndex=sender.tag;
            NSIndexSet *reloadIndexSet=[NSIndexSet indexSetWithIndex:self.selectIndex];
            [self.testTable reloadSections:reloadIndexSet withRowAnimation:UITableViewRowAnimationFade];
            return;
        }
        self.isReloadtoClose=YES;
        NSIndexSet *deleteIndexSet=[NSIndexSet indexSetWithIndex:self.selectIndex];
        [self.testTable reloadSections:deleteIndexSet withRowAnimation:UITableViewRowAnimationNone];
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
