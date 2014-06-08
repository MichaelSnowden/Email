//
//  ViewController.h
//  Email
//
//  Created by Michael Snowden on 6/5/14.
//  Copyright (c) 2014 Michael Snowden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "RecipientViewController.h"
#import "SharedDataViewController.h"

@interface EmailViewController : SharedDataViewController <MFMailComposeViewControllerDelegate>

@end
