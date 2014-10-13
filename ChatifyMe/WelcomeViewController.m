//
//  WelcomeViewController.m
//  ChatifyMe
//
//  Created by Suhail Bhat on 13/10/14.
//  Copyright (c) 2014 Suhail Bhat. All rights reserved.
//

#import "WelcomeViewController.h"

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


    UIColor* mainColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:1.0f];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view setTintColor:mainColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
