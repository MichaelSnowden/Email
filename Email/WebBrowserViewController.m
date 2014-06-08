//
//  WebBrowserViewController.m
//  Email
//
//  Created by Michael Snowden on 6/6/14.
//  Copyright (c) 2014 Michael Snowden. All rights reserved.
//

#import "WebBrowserViewController.h"

@interface WebBrowserViewController()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebBrowserViewController

- (void)viewDidAppear:(BOOL)animated
{
    NSString *fullURL = [self.sharedData valueForKey:@"fullURL"];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (BOOL)verifyEmailAddress:(NSString *)address
{
    NSString *fullURL = @"http://verify-email.org/";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc] init];
    [webView loadRequest:requestObj];

    NSString *javascriptString = @" ... ";   // this is what I need
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:javascriptString];
    if ([javascriptString isEqualToString:@"OK"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
