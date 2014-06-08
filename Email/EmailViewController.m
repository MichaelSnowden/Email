//
//  ViewController.m
//  Email
//
//  Created by Michael Snowden on 6/5/14.
//  Copyright (c) 2014 Michael Snowden. All rights reserved.
//

#import "EmailViewController.h"
#import <CoreText/CoreText.h>
#define FRAME_COUNT 64

@interface EmailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation EmailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (IBAction)composeButtonPressed:(id)sender {
    NSMutableSet *recipients = [self.sharedData valueForKey:@"addresses"];
    if (recipients && [recipients count] != 0)
    {
        [self displayComposerSheet];
    }
}

-(void)displayComposerSheet
{
    NSMutableSet *recipients = [self.sharedData valueForKey:@"addresses"];

    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;

    [picker setSubject:@"A warning from a friend"];

    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *toRecipients = [NSArray arrayWithObject:@"michaelosnowden@gmail.com"];
    NSArray *bccRecipients = [recipients sortedArrayUsingDescriptors:nil];

    [picker setToRecipients:toRecipients];
    [picker setBccRecipients:bccRecipients];

    NSString *emailBody = @"Your pants are on fire.";
    [picker setMessageBody:emailBody isHTML:NO];

    [self presentViewController:picker animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
