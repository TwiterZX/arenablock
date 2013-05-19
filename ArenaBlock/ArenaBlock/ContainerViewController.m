//
//  ContainerViewController.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "BoardViewController.h"
#import "PiecePickerViewController.h"
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BoardSegue"]) {
        BoardViewController *board = [segue destinationViewController];
        [self addChildViewController:board];
    }
    else if ([segue.identifier isEqualToString:@"PieceSegue"]) {
        PiecePickerViewController *picker = [segue destinationViewController];
        [self addChildViewController:picker];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
