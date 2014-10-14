//
//  ScringoFeedbackTalkToUsViewController.h
//  Scringo
//
//  Created by Ofer Kalisky on 12/16/12.
//  Copyright (c) 2012 Ziggy Software. All rights reserved.
//

#import "ScringoGeneralFeatureViewController.h"

/** Delegate for the Feedback Talk to Us view controller. */
@protocol ScringoFeedbackTalkToUsViewControllerDelegate
/** Dismiss the Talk to Us view. */
-(void)dismissTalkToUs;
@end

/** Feedback Talk to Us view controller.
 
 This view controller loads and controls the screen holding the Feedback Talk to Us panel.
 */
@interface ScringoFeedbackTalkToUsViewController : ScringoGeneralFeatureViewController

/** Initialize the Feedback Talk to Us view.
 
 Initialize the Feedback Talk to Us view from its interface builder definition file.
 This object can later be pushed into an existing navigation controller, a container view controller or even modally.
 @param text Initial text in the feedback.
 @param delegate The object implementing the required delegate protocol.
 */
-(id)initFromNibWithText:(NSString *)text withDelegate:(id<ScringoFeedbackTalkToUsViewControllerDelegate>)delegate;

@end
