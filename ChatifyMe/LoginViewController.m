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
#import <FacebookSDK/FacebookSDK.h>
#import <Scringo/Scringo.h>

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userNameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *enterChatButton;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (nonatomic, assign) BOOL duringCancel;

@property (nonatomic, strong) PFSignUpViewController *signUPController;
@property (nonatomic, strong) PFLogInViewController *loginController;

@property (nonatomic, strong) UIAlertView *alert;
@property (nonatomic, strong) id<ADVAnimationController> animationController;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.center = self.view.center;
    [self.view addSubview:loginView];
    self.loginController = [[PFLogInViewController alloc] init];
    self.signUPController = [[PFSignUpViewController alloc] init];
    self.loginController.delegate = self;
    self.signUPController.delegate = self;
    [self.enterChatButton addTarget:self action:@selector(enterChat:) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpButton addTarget:self action:@selector(enterChat:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.userNameField.text = nil;
    [self.userNameField becomeFirstResponder];
    if (! self.duringCancel && ![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate

        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate

        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];

        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    } else if ([PFUser currentUser] && [PFUser currentUser].isAuthenticated) {

        [ScringoUser loginWithEmail:[PFUser currentUser].email password:@"p" completion:^(ScringoUser *user, BOOL isSuccess) {
            if (isSuccess) {
                [[PFUser currentUser] setObject:user.userId forKey:@"ScringoUserId"];
                [[PFUser currentUser] saveInBackground];
            }
        }];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UINavigationController* controller;
        controller = [storyboard instantiateViewControllerWithIdentifier:@"NavViewController"];
        self.animationController = [[ZoomAnimationController alloc] init];
        controller.transitioningDelegate  = self;
        [self presentViewController:controller animated:YES completion:nil];
    }

    self.duringCancel = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enterChat:(id)sender {

    //UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController* controller;

    if(sender == self.enterChatButton){
        controller = (UINavigationController*)self.loginController;//[storyboard instantiateViewControllerWithIdentifier:@"NavViewController"];
        self.animationController = [[ZoomAnimationController alloc] init];
    }else{
        controller = (UINavigationController*)self.signUPController;//[storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
        self.animationController = [[DropAnimationController alloc] init];
    }
    controller.transitioningDelegate  = self;
    PFUser *Puser = [PFUser currentUser];
    if (![PFUser currentUser]) {
        // Create a User in parse.
        Puser = [PFUser user];
        if ([self validateUserNameField]) {
            Puser.username = self.userNameField.text;
            Puser.password = @"my pass";
            Puser.email = [self.userNameField.text stringByAppendingString:@"@chatifyme.com"];

            // other fields can be set if you want to save more information
            Puser[@"phone"] = @"650-555-0000";
            [Puser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    self.alert = [[UIAlertView alloc] initWithTitle:@"Logging In..." message:@"Please wait" delegate:self cancelButtonTitle:@"" otherButtonTitles:nil];
                    [self.alert show];
                    [self performSelector:@selector(loginTheUserToChat:) withObject:Puser afterDelay:0.3];
                } else {
                    NSString *errorString = [error userInfo][@"error"];
                    NSLog(@"%@", errorString);
                    if ([errorString isEqualToString:[NSString stringWithFormat:@"username %@ already taken", Puser.username]]) {
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
//    [ScringoUser loginWithEmail:Puser.username password:Puser.password completion:^(ScringoUser *user, BOOL isSuccess) {
//        if (isSuccess) {
//            [Puser setObject:user.userId forKey:@"ScringoUserId"];
//            [Puser saveInBackground];
//        }
//    }];

    [self presentViewController:controller animated:YES completion:nil];
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

#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;

    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }

    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }

    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [ScringoUser signUpWithEmail:user.email userName:user.username password:user.password completion:^(ScringoUser *aUser, BOOL isSuccess) {
        if (isSuccess) {
            [user setObject:aUser.userId forKey:@"ScringoUserId"];
            [user saveInBackground];
        }
    }];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }

    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {

    [ScringoUser loginWithEmail:user.email password:logInController.logInView.passwordField.text completion:^(ScringoUser *aUser, BOOL isSuccess) {
        if (isSuccess) {
            [user setObject:aUser.userId forKey:@"ScringoUserId"];
            [user saveInBackground];
        }
    }];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    self.duringCancel = YES;
    [self.navigationController popViewControllerAnimated:YES];
}



@end
