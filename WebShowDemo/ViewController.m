//
//  ViewController.m
//  WebShowDemo
//
//  Created by quiet on 15/7/22.
//  Copyright (c) 2015年 quiet. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate,UITextFieldDelegate>
@property (strong,nonatomic) UIWebView *webView;

@property (strong,nonatomic) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //演示App中界面使用web显示
    
    //<1>使用UIWebView加载网址(网址)
    //  代理方法
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 260, 35)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    self.navigationItem.titleView = _textField;
    _textField.text = @"http://www.baidu.com";
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"打开" style:UIBarButtonItemStylePlain target:self action:@selector(dealOpen)];
    self.navigationItem.rightBarButtonItem = openItem;
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    
    //<2>使用UIWebView加载网页数据 *****
    //  25/40 使用webView显示界面
    //  (1)HTML语法(网页的语法)
    //  (2)HTML如何加载

    
    //<3>如何使用Javascript语言控制网页
    //  (1)Javascript语言
    //  (2)Javascript和webView的交互
    //  (3)常见问题
    
    
    //<4>使用TFHpple处理HTML文件
}
//代理方法 - 开始请求执行
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"url = %@",request.URL);
    //默认返回yes, 表示允许请求
    return YES;
}
//代理方法 - 加载完成之后执行
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成");
    
    //使用JS语句操作网页
    //(1)获取网页标题
    //  js = document.title
    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"title = %@",title);
    
    //(2)获取网页地址
    NSString *url = [_webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    NSLog(@"url = %@",url);
    
    //(3)自动输入用户名和密码
    //js = @"document.getElementsByName('username')[0].value='zhangsan'"
    //js = @"document.getElementsByName('password')[0].value='123456'"
    [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('username')[0].value='zhangsan'"];
    [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('password')[0].value='123456'"];
    
    //(4)修改图片的大小
    //注意: 有些图片需要高度x2才能正常显示
    [_webView stringByEvaluatingJavaScriptFromString:
     @"for(var i=0; i<document.images.length; i++){"
     "var img = document.images[i];"
     "var oldWidth = img.width;"
     "img.width = 320;"
     "img.height = img.height * (320 / oldWidth);}"
     ];
    NSString *str = @"test"
    "hello";
    NSLog(@"str = %@",str);
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)dealOpen
{
    //打开网页
    //[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_textField.text]]];
    
    //加载网页数据文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.html" ofType:nil];
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:string baseURL:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
