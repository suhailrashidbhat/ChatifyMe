//
//  WelcomeViewController.m
//  ChatifyMe
//
//  Created by Suhail Bhat on 13/10/14.
//  Copyright (c) 2014 Suhail Bhat. All rights reserved.
//

#import "WelcomeViewController.h"
//#import <Scringo/Scringo.h>
//#import <Scringo/ScringoUser.h>

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissController:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapGesture];

    [self.goButton addTarget:self action:@selector(dismissController:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)newChat:(id)sender {
    
}

-(void)dismissController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)logOut:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
