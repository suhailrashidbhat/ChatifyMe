//
//  LoginViewController.m
//  ChatifyMe
//
//  Created by Suhail Bhat on 12/10/14.
//  Copyright (c) 2014 Suhail Bhat. All rights reserved.
//


#import "LoginViewController.h"
#import "ViewController.h"
#import "WelcomeViewController.h"
#import "TransitionControllers/ADVAnimationController.h"
#import "TransitionControllers/DropAnimationController.h"
#import "TransitionControllers/ZoomAnimationController.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userNameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *enterChatButton;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;

@property (nonatomic, strong) UIAlertView *alert;
@property (nonatomic, strong) id<ADVAnimationController> animationController;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.enterChatButton addTarget:self action:@selector(enterChat:) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpButton addTarget:self action:@selector(enterChat:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.userNameField.text = nil;
    [self.userNameField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enterChat:(id)sender {

    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController* controller;

    if(sender == self.enterChatButton){
        controller = [storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
        self.animationController = [[ZoomAnimationController alloc] init];
    }else{
        controller = [storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
        self.animationController = [[DropAnimationController alloc] init];
    }

    controller.transitioningDelegate  = self;
    [self presentViewController:controller animated:YES completion:nil];


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

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.animationController.isPresenting = YES;
    return self.animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animationController.isPresenting = NO;
    return self.animationController;
}


@end
