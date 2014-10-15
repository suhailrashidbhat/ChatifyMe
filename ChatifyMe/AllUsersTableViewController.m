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
@property (nonatomic, strong) NSMutableArray *usersWithin500m;
@property (nonatomic, strong) NSMutableArray *usersWithin1000m;
@property (nonatomic, strong) NSMutableArray *usersWithin5000m;
@property (nonatomic, strong) NSMutableArray *usersFar;

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
    self.usersWithin500m = [NSMutableArray array];
    self.usersWithin1000m = [NSMutableArray array];
    self.usersWithin5000m = [NSMutableArray array];
    self.usersFar = [NSMutableArray array];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xCCFFFF)];
    [self seggregateUsersBasedOnLocation];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)seggregateUsersBasedOnLocation {
    for (int i = 0; i < [self.allUsers count]; i++) {
        __block PFUser *user = (PFUser*)self.allUsers[i];
        [ScringoUser getUserByScringoId:[user objectForKey:@"ScringoUserId"] completion:^(ScringoUser *sUser, BOOL isSuccess) {
            if (sUser.distanceFromMe < 500) {
                [self.usersWithin500m addObject:user];
            } else if (sUser.distanceFromMe < 1000) {
                [self.usersWithin1000m addObject:user];
            } else if (sUser.distanceFromMe < 5000) {
                [self.usersWithin5000m addObject:user];
            } else {
                [self.usersFar addObject:user];
            }
            [self.tableView reloadData];
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self.usersWithin500m count];
            break;
        case 1:
            return [self.usersWithin1000m count];
            break;
        case 2:
            return [self.usersWithin5000m count];
            break;
        case 3:
            return [self.usersFar count];
            break;
        default:
            break;
    }
    // Return the number of rows in the section.
    return [self.allUsers count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Users within 500 mts.";
            break;
        case 1:
            return @"Users within 1000 mts.";
            break;
        case 2:
            return @"Users within 5000 mts.";
            break;
        case 3:
            return @"All Others";
            break;
        default:
            break;
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    PFUser *user;
    switch (indexPath.section) {
        case 0:
            user = [self.usersWithin500m objectAtIndex:indexPath.row];
            break;
        case 1:
            user = [self.usersWithin1000m objectAtIndex:indexPath.row];
            break;
        case 2:
            user = [self.usersWithin5000m objectAtIndex:indexPath.row];
            break;
        case 3:
            user = [self.usersFar objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }

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
    PFUser *user;
    switch (indexPath.section) {
        case 0:
            user = [self.usersWithin500m objectAtIndex:indexPath.row];
            break;
        case 1:
            user = [self.usersWithin1000m objectAtIndex:indexPath.row];
            break;
        case 2:
            user = [self.usersWithin5000m objectAtIndex:indexPath.row];
            break;
        case 3:
            user = [self.usersFar objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }

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
