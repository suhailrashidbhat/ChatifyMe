//
//  AllUsersTableViewController.m
//  ChatifyMe
//
//  Created by Suhail Bhat on 14/10/14.
//  Copyright (c) 2014 Suhail Bhat. All rights reserved.
//

#import "AllUsersTableViewController.h"
#import <Parse/Parse.h>
#import <Scringo/Scringo.h>
#import "ScringoStyleCheet.h"

@interface AllUsersTableViewController ()

@property (nonatomic, strong) ScringoStyleCheet *styleCheet;

@end

@implementation AllUsersTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    // Not really recommended to do this in the viewDidLoad, but OK for this sample
    PFQuery *query = [PFUser query];
    self.allUsers = [query findObjects];
    NSLog(@"You have %d users, I am %@", [self.allUsers count], [PFUser currentUser].username);
    self.styleCheet = [[ScringoStyleCheet alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.allUsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }


    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    [cell.textLabel setText:user.username];
    if ([[user objectId] isEqual:[[PFUser currentUser] objectId]]) {
        [cell.detailTextLabel setText:NSLocalizedString(@"This is me :-)", nil)];
    } else {
        [cell.detailTextLabel setText:NSLocalizedString(@"Click to chat", nil)];
    }

    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    if ([[user objectId] isEqual:[[PFUser currentUser] objectId]]) {
        return;
    }
    NSLog(@"Selected user scringo id is %@", [user objectForKey:@"ScringoUserId"]);


    [Scringo setCustomStyleSheet:self.styleCheet];

    [ScringoUser getUserByScringoId:[user objectForKey:@"ScringoUserId"] completion:
     ^(ScringoUser *aUser, BOOL isSuccess) {
         if (isSuccess) {
             NSLog(@"Selected user in scringo: %@, %@", aUser.email, aUser.firstName);
             [Scringo openChatWithUser:aUser.userId withNavigationController:self.navigationController withScringoNavControllerEnabled:NO];
         } else {
             NSLog(@"Failed getting user");
         }
     }];



}

@end
