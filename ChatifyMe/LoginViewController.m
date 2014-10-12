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


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}
- (IBAction)enterChat:(id)sender {
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
                // Hooray! Let them use the app now.
                [self loginTheUserToChat:user];
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
         [self enterChatView];
    }];
}

-(void)enterChatView {
    [self performSegueWithIdentifier:@"showChatView" sender:self];
}


@end
