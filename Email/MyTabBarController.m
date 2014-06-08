//
//  MyTabBarController.m
//  Email
//
//  Created by Michael Snowden on 6/6/14.
//  Copyright (c) 2014 Michael Snowden. All rights reserved.
//

#import "MyTabBarController.h"
#import "SharedDataViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MyTabBarController ()

@property (nonatomic, strong) NSMutableDictionary *sharedData;
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation MyTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITabBarItem *item1 = self.tabBar.items[0];
    UITabBarItem *item2 = self.tabBar.items[1];
    UITabBarItem *item3 = self.tabBar.items[2];
    item1.image = [UIImage imageNamed:@"at_symbol.png"];
    item2.image = [UIImage imageNamed:@"email.png"];
    item3.image = [UIImage imageNamed:@"safari.png"];
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];

    self.sharedData = [NSMutableDictionary new];

    for (SharedDataViewController *vc in self.viewControllers)
    {
        vc.sharedData = self.sharedData;
    }

    NSString *path = [[NSBundle mainBundle] pathForResource:@"Unity" ofType:@"mp3"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _player.numberOfLoops = -1;
    [_player prepareToPlay];
    [_player play];
}

@end
