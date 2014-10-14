//
//  WelcomeViewController.m
//  ChatifyMe
//
//  Created by Suhail Bhat on 13/10/14.
//  Copyright (c) 2014 Suhail Bhat. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MembersTableViewController.h"
#import "AllUsersTableViewController.h"
#import <Parse/Parse.h>
#import <Scringo/Scringo.h>
#import <Scringo/ScringoUser.h>

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.goButton addTarget:self action:@selector(dismissController:) forControlEvents:UIControlEventTouchUpInside];
    if ([PFUser currentUser]) {
        self.title = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
    } else {
        self.title = NSLocalizedString(@"Not logged in", nil);
    }
    [self.navigationController.navigationBar setBackgroundColor:[UIColor brownColor]];
    [self.tableView setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)newChat:(id)sender {
    
}

-(void)dismissController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)logOut:(id)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    // Configure the cell (ugly code...)
    if (indexPath.row == 0) {
        [cell.textLabel setText:NSLocalizedString(@"ChatifyMe !!", nil)];
    } else if (indexPath.row == 1) {
        [cell.textLabel setText:NSLocalizedString(@"See other users", nil)];
        [cell.detailTextLabel setText:NSLocalizedString(@"Choose a user to chat with", nil)];
    } else if (indexPath.row == 2) {
        [cell.textLabel setText:@"Delete entire database on Server!"];
        [cell.detailTextLabel setText:@"Be sure before selecting..."];
    } 
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        // Open group Chat with all !
        [ScringoChatRoom getChatRoomByObjectId:@"objID" withObjectType:@"type" withTitle:@"Chatify" withData:@"data" completion:^(ScringoChatRoom *chatRoom, BOOL isSuccess) {
            [Scringo openChatRoomWithTopic:chatRoom withNavigationController:self.navigationController withScringoNavControllerEnabled:YES];
        }];
    } else if (indexPath.row == 1) {
        AllUsersTableViewController *allUsersVC = [[AllUsersTableViewController alloc] init];
        [self.navigationController pushViewController:allUsersVC animated:YES];
    } else if (indexPath.row == 2) {
        UIAlertView *jkAlert = [[UIAlertView alloc] initWithTitle:@"This is a JOKE !! You can't do it... " message:@"Enjoy ChatifyMe" delegate:self cancelButtonTitle:@"Ha ha.." otherButtonTitles:nil];
        [jkAlert show];
    }
}
- (IBAction)createGroup:(id)sender {
    [Scringo openCreateChatRoom];
}


@end
