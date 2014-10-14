//
//  SignUpViewController.m
//  ChatifyMe
//
//  Created by Suhail Bhat on 14/10/14.
//  Copyright (c) 2014 Suhail Bhat. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissController:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapGesture];

    [self.backButton addTarget:self action:@selector(dismissController:) forControlEvents:UIControlEventTouchUpInside];


    UIColor* mainColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:1.0f];
    [self.view setTintColor:mainColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//    // Create a User in parse.
//    PFUser *user = [PFUser user];
//    if ([self validateUserNameField]) {
//        user.username = self.userNameField.text;
//        user.password = @"my pass";
//        user.email = [self.userNameField.text stringByAppendingString:@"@chatifyme.com"];
//
//        // other fields can be set if you want to save more information
//        user[@"phone"] = @"650-555-0000";
//
//        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            if (!error) {
//                self.alert = [[UIAlertView alloc] initWithTitle:@"Logging In..." message:@"Please wait" delegate:self cancelButtonTitle:@"" otherButtonTitles:nil];
//                [self.alert show];
//                [self performSelector:@selector(loginTheUserToChat:) withObject:user afterDelay:0.3];
//            } else {
//                NSString *errorString = [error userInfo][@"error"];
//                NSLog(@"%@", errorString);
//                if ([errorString isEqualToString:[NSString stringWithFormat:@"username %@ already taken", user.username]]) {
//                    // Login  him. Already exists.
//                }
//                UIAlertView *errorFromParse = [[UIAlertView alloc] initWithTitle:@"Registering Error!" message:errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                [errorFromParse show];
//            }
//        }];
//    } else {
//        // Do say !
//    }

@end
