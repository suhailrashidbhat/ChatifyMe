//
//  LoginViewController.h
//  ChatifyMe
//
//  Created by Suhail Bhat on 12/10/14.
//  Copyright (c) 2014 Suhail Bhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UIViewControllerTransitioningDelegate>

@end
