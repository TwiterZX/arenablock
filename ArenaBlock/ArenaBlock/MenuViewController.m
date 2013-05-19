//
//  MenuViewController.m
//  ArenaBlock
//
//  Created by Clement Yerochewski on 19/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "MBProgressHUD.h"
#import "WebServiceClient.h"
#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - action

- (IBAction)action_currentGame:(id)sender
{
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"NewGameSegue"])
    {
        if ([[WebServiceClient sharedInstance] isInternetAvailable] != TRUE) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = @"No internet access";
            hud.mode = MBProgressHUDModeText;
            
            
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            
            return FALSE;
        }
    }
    return YES;
}

@end
