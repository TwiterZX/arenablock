//
//  WaitingUserViewController.m
//  ArenaBlock
//
//  Created by Salhi Yacine on 19/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
#import "NSObject+SBJson.h"
#import "WaitingUserViewController.h"
#import "GameManager.h"
#import "ContainerViewController.h"

@interface WaitingUserViewController ()

@end

@implementation WaitingUserViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[WebServiceClient sharedInstance] setWsdelegate:self];
    [[WebServiceClient sharedInstance] createGame];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Waiting for a player";
    hud.mode = MBProgressHUDModeIndeterminate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebService Protocol

- (void)createGameSuccess:(ASIHTTPRequest *)request {
    NSString *answer = [request responseString];
    NSDictionary *dic = [answer JSONValue];
    
    DLog(@"Create Game success %@", dic);

    [[GameManager sharedInstance] createGameWithInformation:dic];
}

- (void)createGameFailed:(NSString *)answer {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = answer;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

- (void)joinedGameSuccess:(NSDictionary *)dic {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"We found a player";

    [[GameManager sharedInstance] gameHadBeenJoined];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        ContainerViewController *cc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContainerViewController"];
        [self addChildViewController:cc];
        [self.view addSubview:cc.view];
    });
}

@end
