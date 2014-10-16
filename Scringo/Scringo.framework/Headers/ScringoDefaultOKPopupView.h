//
//  ScringoDefaultOKPopupView.h
//  Scringo
//
//  Created by Ofer Kalisky on 1/11/13.
//  Copyright (c) 2013 Ziggy Software. All rights reserved.
//

/** Delegate for the Popup view.
 */
@protocol ScringoDefaultOKPopupViewDelegate <NSObject>
/** Popup OK button clicked.
 */
-(void)popupOkTapped;
/** Popup Cancel button clicked.
 */
-(void)popupCancelTapped;
@optional
/** Popup is about to dismiss.
 */
-(void)popupDismissed;
@end

/** Simple Popup view implmenetation.
 
 Allows for one or two button popup view to be displayed.
 */
@interface ScringoDefaultOKPopupView : UIView <UIGestureRecognizerDelegate>
/** Delegate of the popup view.
 */
@property (nonatomic, assign) id<ScringoDefaultOKPopupViewDelegate> delegate;
/** Define whether the popup should close on orientation changes. Default is YES.
 */
@property (nonatomic, assign) BOOL closeOnOrientationChange;

/** Initialize a single button popup view from its nib file.
 
 @param okButtonTitle The single button title.
 */
-(id)initFromNib:(NSString *)okButtonTitle;
/** Initialize a two buttons popup view from its nib file.

 @param okButtonTitle The 'ok' button title.
 @param cancelButtonTitle The 'cancel' button title.
 */
-(id)initFromNib:(NSString *)okButtonTitle cancel:(NSString *)cancelButtonTitle;

/** Set the popup title and message.
 
 @param title The popup Title.
 @param message The popup message.
 */
-(void)setPopupTitle:(NSString *)title message:(NSString *)message;

/** Make the popup view show itself.
 
 By default, any touch outside the popup is regarded as a request to dismiss the popup.
 
 @param view The view the popup should show in.
 */
-(void)showInView:(UIView *)view;
/** Make the popup view show itself.

 @param view The view the popup should show in.
 @param disableTouchesOutside Whether to disable touches outside the popup, or not.
 */
-(void)showInView:(UIView *)view disableTouchesOutside:(BOOL)disableTouchesOutside;
/** Make the popup view show itself.

 @param view The view the popup should show in.
 @param origin The top left coordinate to place the popup view in.
 @param disableTouchesOutside Whether to disable touches outside the popup, or not.
 */
-(void)showInView:(UIView *)view atPosition:(CGPoint)origin disableTouchesOutside:(BOOL)disableTouchesOutside;

/** Close the popup view.
 */
-(void)close;
@end
