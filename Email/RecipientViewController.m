//
//  AddressViewController.m
//  Email
//
//  Created by Michael Snowden on 6/5/14.
//  Copyright (c) 2014 Michael Snowden. All rights reserved.
//

#import "RecipientViewController.h"
#import "MyTabBarController.h"
#define FRAME_COUNT 64

@interface RecipientViewController()

@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UITextView *addressesTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation RecipientViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.urlTextField.delegate = self;
    self.scrollView.layer.borderWidth = 2;
    self.scrollView.layer.borderColor = [UIColor blackColor].CGColor;

    NSMutableArray *frames = [[NSMutableArray alloc] initWithCapacity:FRAME_COUNT];
    for (int i = 0; i < FRAME_COUNT; ++i)
    {
        NSString *name = [NSString stringWithFormat:@"frame_%03i.gif", i];
        UIImage *image = [UIImage imageNamed:name];
        [frames addObject:image];
    }

    self.imageView.animationImages = frames;
    self.imageView.animationDuration = 2.0f;
    self.imageView.animationRepeatCount = 0;
    [self.imageView startAnimating];

    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.sharedData setValue:self.urlTextField.text forKey:@"fullURL"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getAddressButtonPressed:(id)sender
{
    NSMutableSet *addresses = [self fetchEmailsFromUrlPath:self.urlTextField.text];
    [self.sharedData setValue:addresses forKey:@"addresses"];
}

-(NSMutableSet *)fetchEmailsFromUrlPath:(NSString *)path;
{
    NSURL *URL = [NSURL URLWithString:path];
    NSError *error;
    NSString *pageAsHTMLString = [NSString stringWithContentsOfURL:URL
                                                    encoding:NSASCIIStringEncoding
                                                       error:&error];


    if (!pageAsHTMLString)
    {
        return nil;
    }
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:pattern
                                  options:0
                                  error:nil];
    NSArray *myArray = [regex matchesInString:pageAsHTMLString options:0 range:NSMakeRange(0, [pageAsHTMLString length])] ;
    NSMutableArray *matches = [NSMutableArray arrayWithCapacity:[myArray count]];

    for (NSTextCheckingResult *match in myArray) {
        NSRange matchRange = [match rangeAtIndex:0];
        [matches addObject:[pageAsHTMLString substringWithRange:matchRange]];
    }

    NSMutableSet *addresses = [NSMutableSet setWithArray:matches];
    self.addressesTextField.text = [self stringFromSet:addresses];

    return addresses;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)pasteButtonPressed:(id)sender
{
    self.urlTextField.text = [self paste];
}

- (NSString *)paste
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    return pasteBoard.string;
}

- (NSString *)stringFromSet:(NSMutableSet *)set
{
    return [[set allObjects] componentsJoinedByString:@"\n"];
}

@end
