//
//  webView.m
//  DemoUitils
//
//  Created by kim on 01/11/2017.
//  Copyright © 2017 kim. All rights reserved.
//

#import "webView.h"
#import <WebKit/WebKit.h>
@interface webView()<WKScriptMessageHandler,WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *webview;
@end
@implementation webView
-(void)viewDidLoad{
    [super viewDidLoad];
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
    config.preferences.minimumFontSize=18;
    
    _webview=[[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
    //_webview.navigationDelegate=self;
   [self.view addSubview:_webview];
    //[self loadDocument:@"a.html" withconfig:config];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"a" ofType:@"html"];
    NSURL *baseURL=[[NSBundle mainBundle]bundleURL];
    [_webview loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    WKUserContentController *userCC=config.userContentController;
    [userCC addScriptMessageHandler:self name:@"showMobile"];
     [userCC addScriptMessageHandler:self name:@"getName"];
    [userCC addScriptMessageHandler:self name:@"showUserInfo"];
}
-(void)loadDocument:(NSString *)docName withconfig:(WKWebViewConfiguration*)config{
   
    
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if([message.name isEqualToString:@"showMobile"]){
        NSLog(@"%@",message.name);
        [self.webview evaluateJavaScript:@"test1('222')" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"%@",response);
        }];
    }
    if([message.name isEqualToString:@"getName"]){
        [self.webview evaluateJavaScript:@"test1(333)" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"%@",response);
        }];
        NSLog(@"%@",message.name);
    }
    if([message.name isEqualToString:@"showUserInfo"]){
        
    }
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
   
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
   
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
}
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
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
