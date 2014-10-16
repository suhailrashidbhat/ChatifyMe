//
//  ScringoStyleCheet.m
//  ChatifyMe
//
//  Created by Suhail Bhat on 14/10/14.
//  Copyright (c) 2014 Suhail Bhat. All rights reserved.
//

#import "ScringoStyleCheet.h"


@implementation ScringoStyleCheet

-(void)customizeDefaultButtonStyle:(UIButton *)aButton inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [aButton setBackgroundImage:[UIImage imageNamed:@"BlueBtn"] forState:UIControlStateNormal];
    [aButton setBackgroundImage:[UIImage imageNamed:@"BlueBtnPressed"] forState:UIControlStateHighlighted];
}

-(void)customizeBackgroundView:(UIImageView *)backgroundView inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    backgroundView.backgroundColor = [UIColor colorWithRed:216.0/255 green:240.0/255 blue:248.0/255 alpha:1];
    backgroundView.image = nil;
}

-(void)customizeNavbarView:(UIView *)navView inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    navView.backgroundColor = [UIColor colorWithRed:0 green:117.0/255 blue:186.0/255 alpha:1];
}

-(void)customizeBackButton:(UIButton *)backButton inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    [backButton setBackgroundImage:nil forState:UIControlStateNormal];
    [backButton setBackgroundImage:nil forState:UIControlStateHighlighted];
}

-(void)customizeTableCellSelectedBackgroundView:(UIView *)selectedBackgroundView inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    selectedBackgroundView.backgroundColor = [UIColor colorWithRed:143.0/255 green:187.0/255 blue:205.0/255 alpha:1];
}

-(void)customizeProfileMidBarView:(UIView *)midBarView inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    midBarView.backgroundColor = [UIColor colorWithRed:143.0/255 green:187.0/255 blue:205.0/255 alpha:1];
    UIButton *myProfileCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myProfileCustomButton setFrame:CGRectMake(10, 10, 50, 30)];
    [myProfileCustomButton setTitle:@"More" forState:UIControlStateNormal];
    [myProfileCustomButton setTitle:@"More" forState:UIControlStateHighlighted];
    [self customizeDefaultButtonStyle:myProfileCustomButton inScreen:inScreen];
    [myProfileCustomButton addTarget:self action:@selector(customButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [midBarView addSubview:myProfileCustomButton];
}
-(void)customButtonClicked {
    NSLog(@"Clicked on my custom button");
}
-(void)customizeProfileMidBarTopImageView:(UIImageView *)midBarTopImageView inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    midBarTopImageView.hidden = YES;
}
-(void)customizeProfileMidBarTopShadeView:(UIImageView *)midBarShadeImageView inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    midBarShadeImageView.hidden = YES;
}
-(void)customizeTableCellTitleLabel:(UILabel *)cellTitleLabel inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    cellTitleLabel.textColor = [UIColor colorWithRed:0/255 green:116.0/255 blue:185.0/255 alpha:1];
    cellTitleLabel.shadowOffset = CGSizeMake(0, 0);
}
-(void)customizeTableCellTimeLabel:(UILabel *)cellTimeLabel inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    cellTimeLabel.textColor = [UIColor colorWithRed:143.0/255 green:143.0/255 blue:143.0/255 alpha:1];
    cellTimeLabel.shadowOffset = CGSizeMake(0, 0);
}
-(void)customizeTableCellDescriptionLabel:(UILabel *)cellDescriptionLabel inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    cellDescriptionLabel.textColor = [UIColor colorWithRed:143.0/255 green:143.0/255 blue:143.0/255 alpha:1];
    cellDescriptionLabel.shadowOffset = CGSizeMake(0, 0);
}
-(void)customizeChatroomHeaderTitle:(UILabel *)titleLabel inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    titleLabel.textColor = [UIColor colorWithRed:0/255 green:116.0/255 blue:185.0/255 alpha:1];
    titleLabel.shadowOffset = CGSizeMake(0, 0);
}

-(void)customizePostMessageBackgroundView:(UIImageView *)postBackgroundView inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    postBackgroundView.image = nil;
    postBackgroundView.backgroundColor = [UIColor colorWithRed:175.0/255 green:211.0/255 blue:244.0/255 alpha:1];
}
-(void)customizeChatMyMessageBackgroundImageView:(UIImageView *)myMessageBackgroundImageView inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    myMessageBackgroundImageView.image = [UIImage imageNamed:@"BlueChatBubble"];
}

-(void)customizeChatOtherMessageBackgroundImageView:(UIImageView *)otherMessageBackgroundImageView inScreen:(ScringoStyleSheetScreenIdentifier)inScreen  {
    otherMessageBackgroundImageView.image = [UIImage imageNamed:@"GreenChatBubble"];
}

-(void)customizeProfileNameLabel:(UILabel *)nameLabel inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    nameLabel.textColor = [UIColor colorWithRed:0/255 green:116.0/255 blue:185.0/255 alpha:1];
}
-(void)customizeProfileBadUserButton:(UIButton *)badUserButton inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    [badUserButton setImage:[UIImage imageNamed:@"ScrImg_UserMoreIcon"] forState:UIControlStateNormal];
    [badUserButton setBackgroundImage:nil forState:UIControlStateNormal];
    [badUserButton setBackgroundImage:nil forState:UIControlStateHighlighted];
}
-(void)customizeLikeOnButton:(UIButton *)likeOnButton inScreen:(ScringoStyleSheetScreenIdentifier)inScreen  {
    [likeOnButton setImage:[UIImage imageNamed:@"LikeIcon"] forState:UIControlStateNormal];
    [likeOnButton setImage:[UIImage imageNamed:@"LikeIcon"] forState:UIControlStateHighlighted];
}
-(void)customizeChatroomHeaderCommentsButton:(UIButton *)commentsButton inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    [commentsButton setImage:[UIImage imageNamed:@"CommentIcon"] forState:UIControlStateNormal];
    [commentsButton setImage:[UIImage imageNamed:@"CommentIcon"] forState:UIControlStateHighlighted];
}

-(void)customizeUsersListSearchField:(UITextField *)searchField inScreen:(ScringoStyleSheetScreenIdentifier)inScreen   {
    searchField.background = [UIImage imageNamed:@"PostField"];
}

-(void)customizeActivityBackgroundView:(UIImageView *)backgroundView inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    backgroundView.image = [UIImage imageNamed:@"PostBg"];
}

-(void)customizeTableSectionHeaderImageView:(UIImageView *)sectionHeaderView inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    sectionHeaderView.backgroundColor = [UIColor colorWithRed:143.0/255 green:187.0/255 blue:205.0/255 alpha:1];
    sectionHeaderView.image = nil;
}
-(void)customizeTableSectionHeaderLabel:(UILabel *)sectionHeaderLabel inScreen:(ScringoStyleSheetScreenIdentifier)inScreen {
    sectionHeaderLabel.textColor = [UIColor colorWithRed:0/255 green:116.0/255 blue:185.0/255 alpha:1];
    sectionHeaderLabel.shadowOffset = CGSizeMake(0, 0);
}


@end
