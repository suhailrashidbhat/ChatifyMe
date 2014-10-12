//
//  LoginViewController.m
//  ChatifyMe
//
//  Created by Suhail Bhat on 12/10/14.
//  Copyright (c) 2014 Suhail Bhat. All rights reserved.
//


#import "LoginViewController.h"
#import "ViewController.h"


@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userNameField;
@property (strong, nonatomic) IBOutlet UIButton *enterChatButton;
@property (nonatomic, strong) UIAlertView *alert;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.userNameField.text = nil;
    [self.userNameField becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showChatView"]) {
        [self enterChat];
    }
}

- (void)enterChat {
    // Create a User in parse.
    PFUser *user = [PFUser user];
    if ([self validateUserNameField]) {
        user.username = self.userNameField.text;
        user.password = @"my pass";
        user.email = [self.userNameField.text stringByAppendingString:@"@chatifyme.com"];

        // other fields can be set if you want to save more information
        user[@"phone"] = @"650-555-0000";

        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                self.alert = [[UIAlertView alloc] initWithTitle:@"Logging In..." message:@"Please wait" delegate:self cancelButtonTitle:@"" otherButtonTitles:nil];
                [self.alert show];
                [self performSelector:@selector(loginTheUserToChat:) withObject:user afterDelay:0.3];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"%@", errorString);
                if ([errorString isEqualToString:[NSString stringWithFormat:@"username %@ already taken", user.username]]) {
                    // Login  him. Already exists.
                }
                UIAlertView *errorFromParse = [[UIAlertView alloc] initWithTitle:@"Registering Error!" message:errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [errorFromParse show];
            }
        }];
    } else {
        // Do say !
    }
}

-(BOOL)validateUserNameField {
    if (self.userNameField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter username!" message:nil delegate:self cancelButtonTitle:@"Got it!" otherButtonTitles:nil];
        [alert show];
        return false;
    } else {
        return true;
    }
}

-(void)loginTheUserToChat:(PFUser*)userToRegister {
    [PFUser logInWithUsernameInBackground:userToRegister.username password:userToRegister.password block:^(PFUser *user, NSError *error) {
         [self.alert dismissWithClickedButtonIndex:0 animated:YES];
    }];
}


@end
