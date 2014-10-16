//
//  ViewController.m
//  ChatifyMe
//
//  Created by Suhail Bhat on 12/10/14.
//  Copyright (c) 2014 Suhail Bhat. All rights reserved.
//
#define kOFFSET_FOR_KEYBOARD 216.0
#define MAX_ENTRIES_LOADED 200
#define TABBAR_HEIGHT 49.0

#import "ViewController.h"
#import "ChatCell.h"

@interface ViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UITableView *chatTable;
@property (strong, nonatomic) IBOutlet UIButton *lgoutButton;
@property (nonatomic, strong) NSMutableArray *chatData;
@property (nonatomic, assign) BOOL reloading;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.chatData = [NSMutableArray array];
    self.chatTable.delegate = self;
    self.chatTable.dataSource = self;
    [self.textField setReturnKeyType:UIReturnKeySend];
    [self.textField becomeFirstResponder];
    [self loadChat];
    [self.view setFrame:CGRectMake(0, 0, 320, 480)];
    [self.view setBackgroundColor:UIColorFromRGB(0xCCFFFF)];
    [self.chatTable setBackgroundColor:[UIColor clearColor]];
    //[self registerForKeyboardNotifications];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self freeKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Chat textfield

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.view becomeFirstResponder];
    return YES;
}

-(IBAction)backGroundTap:(id) sender
{
    [self.textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"the text content%@",self.textField.text);
    if (textField == self.textField) {
        [textField becomeFirstResponder];
        if (self.textField.text.length>0) {
            [self sendChat:nil];

        }
    }
    return NO;
}


-(void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void) freeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



#pragma mark - Table view delegate



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.chatData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = (ChatCell *)[tableView dequeueReusableCellWithIdentifier: @"chatCell"];
    NSUInteger row = [self.chatData count]-[indexPath row]-1;
    if (row < self.chatData.count){
        NSString *chatText = [[self.chatData objectAtIndex:row] objectForKey:@"text"];
        cell.chatTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.chatTextLabel.text = chatText;
        [cell.chatTextLabel setTextColor:[UIColor blueColor]];
        [cell.chatTextLabel sizeToFit];

        NSDate *theDate = [[self.chatData objectAtIndex:row] objectForKey:@"date"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm a"];
        NSString *timeString = [formatter stringFromDate:theDate];
        cell.dateLabel.text = timeString;
        cell.nameLabel.text = [[self.chatData objectAtIndex:row] objectForKey:@"userName"];
    }
    [cell setBackgroundColor:UIColorFromRGB(0xCCFFFF)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [[self.chatData objectAtIndex:self.chatData.count-indexPath.row-1] objectForKey:@"text"];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
    CGSize constraintSize = CGSizeMake(225.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    return labelSize.height + 40;
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    self.reloading = YES;
    [self loadChat];
    [self.chatTable reloadData];
}

- (void)doneLoadingTableViewData{

    //  model should call this when its done loading
    self.reloading = NO;
}


- (IBAction)logOut:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [PFUser logOut];
    }];
}

- (IBAction)sendChat:(id)sender {
    // updating the table immediately
    NSArray *keys = [NSArray arrayWithObjects:@"text", @"userName", @"date", nil];
    NSArray *objects = [NSArray arrayWithObjects:self.textField.text, [PFUser currentUser].username, [NSDate date], nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [self.chatData addObject:dictionary];

    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [insertIndexPaths addObject:newPath];
    [self.chatTable beginUpdates];
    [self.chatTable insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.chatTable endUpdates];
    [self.chatTable reloadData];

    // going for the parsing
    PFObject *newMessage = [PFObject objectWithClassName:@"Chats"];
    [newMessage setObject:self.textField.text forKey:@"text"];
    [newMessage setObject:[PFUser currentUser].username forKey:@"userName"];
    [newMessage setObject:[NSDate date] forKey:@"date"];
    [newMessage saveInBackground];
    self.textField.text = @"";
    [self loadChat];
}


#pragma mark - Parse

- (void)loadChat
{
    PFQuery *query = [PFQuery queryWithClassName:@"Chats"];
    if ([self.chatData count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        [query orderByAscending:@"createdAt"];
        NSLog(@"Trying to retrieve from cache");
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %d chats from cache.", objects.count);
                [self.chatData removeAllObjects];
                [self.chatData addObjectsFromArray:objects];
                [self.chatTable reloadData];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        return;
    }
    __block int totalNumberOfEntries = 0;
    [query orderByAscending:@"createdAt"];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            NSLog(@"There are currently %d entries", number);
            totalNumberOfEntries = number;
            if (totalNumberOfEntries > [self.chatData count]) {
                NSLog(@"Retrieving data");
                NSInteger theLimit;
                if (totalNumberOfEntries-[self.chatData count]>MAX_ENTRIES_LOADED) {
                    theLimit = MAX_ENTRIES_LOADED;
                }
                else {
                    theLimit = totalNumberOfEntries-[self.chatData count];
                }
                query.limit = theLimit;
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        // The find succeeded.
                        NSLog(@"Successfully retrieved %d chats.", objects.count);
                        [self.chatData addObjectsFromArray:objects];
                        NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
                        for (int ind = 0; ind < objects.count; ind++) {
                            NSIndexPath *newPath = [NSIndexPath indexPathForRow:ind inSection:0];
                            [insertIndexPaths addObject:newPath];
                        }
                        [self.chatTable beginUpdates];
                        [self.chatTable insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
                        [self.chatTable endUpdates];
                        [self.chatTable reloadData];
                        [self.chatTable scrollsToTop];
                    } else {
                        // Log details of the failure
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                    }
                }];
            }

        } else {
            // The request failed, we'll keep the chatData count?
            number = [self.chatData count];
        }
    }];
}



@end
