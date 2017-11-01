//
//  webView.m
//  DemoUitils
//
//  Created by kim on 01/11/2017.
//  Copyright © 2017 kim. All rights reserved.
//

#import "webView.h"

@interface webView()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webview;
@end
@implementation webView
-(void)viewDidLoad{
    [super viewDidLoad];
    _webview=[UIWebView new];
   
    [self loadDocument:@"a.html"];
    
}
-(void)loadDocument:(NSString *)docName{
   
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    _webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    
    [_webview loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if(navigationType==UIWebViewNavigationTypeLinkClicked){
        NSURL *url=[request URL];
        NSLog(@"url:%@",url);
        return NO;
    }
    
    return YES;
}
@end
