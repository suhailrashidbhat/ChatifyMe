//
//  ScringoQuizProfileViewController.h
//  ScringoExample3
//
//  Created by Guy Federovsky on 20/6/13.
//  Copyright (c) 2014 Ziggy Software. All rights reserved.
//

#import "ScringoGeneralFeatureViewController.h"

/** Quizzes entry point view controller.
 
 This view controller loads and controls the screen which is the entry point to the Quiz system.
 */
@interface ScringoQuizProfileViewController : ScringoGeneralFeatureViewController

/** Initialize the Quizzes entry point view.
 
 Initialize the Quizzes entry point view from its interface builder definition file.
 This object can later be pushed into an existing navigation controller, a container view controller or even modally.
 @param shouldShowProfileButton Should the user profile button be visible or not.
 */
-(id)initFromNib:(BOOL)shouldShowProfileButton;

@end
