//
//  ContainerViewController.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "ContainerViewController.h"
#import "AppDelegate.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[SoundManager sharedManager] playMusic:[appDelegate.bankOfSound valueForKey:@"Jungle"]  looping:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
