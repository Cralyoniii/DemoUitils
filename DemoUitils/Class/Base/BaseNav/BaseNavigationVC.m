//
//  BaseNavigationVC.m
//  DemoUitils
//
//  Created by kim on 28/10/2017.
//  Copyright © 2017 kim. All rights reserved.
//

#import "BaseNavigationVC.h"

@interface BaseNavigationVC ()<UIGestureRecognizerDelegate>
{
    //    NSUserDefaults * users;
}
@end

@implementation BaseNavigationVC


- (void)dealloc
{
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"loadAppVersionFromAppStore"] boolValue])
    //    {
    //        [self loadAppVersionFromAppStore];
    //    }
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 *  重写这个方法目的：能够拦截所有push进来的控制器
 
 @param viewController 即将push进来的控制器
 */

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    //[self.navigationBar setTranslucent:NO];
    [self.navigationBar setBarTintColor:HEX_COLOR(0x2fb1ff)];//HEX_COLOR(0x3092e8)];
    
    self.navigationBar.translucent=NO;
    //设置标题文字颜色和字体大小
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    
    if (self.viewControllers.count > 0) {
        
        //自动显示隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置导航栏上面的内容
        //自定义按钮
        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //设置图片（点击前）
        [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left-c"] forState:UIControlStateNormal];
        //设置图片（点击后，高亮）
        //        [backBtn setBackgroundImage:[UIImage imageNamed:@"back_arrow_white"] forState:UIControlStateHighlighted];
        //设置尺寸
        backBtn.size = backBtn.currentBackgroundImage.size;
        //导航栏左侧按钮
        UIBarButtonItem * leftBarButon = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        // 调整 leftBarButtonItem 在 iOS7 下面的位置
        if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
        {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                           target:nil action:nil];
            negativeSpacer.width = 0;//这个数值可以根据情况自由变化
            viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarButon];
        }else
        {
            viewController.navigationItem.leftBarButtonItem = leftBarButon;
        }
    }
    
    //    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.interactivePopGestureRecognizer.enabled = NO;
    //    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    //因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}




@end
