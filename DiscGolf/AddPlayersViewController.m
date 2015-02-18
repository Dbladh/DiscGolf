//
//  AddPlayersViewController.m
//  DiscGolf
//
//  Created by Daniel Bladh on 2/10/15.
//  Copyright (c) 2015 Daniel Bladh. All rights reserved.
//

#import "AddPlayersViewController.h"
#import <FacebookSDK/FacebookSDK.h>


@interface AddPlayersViewController () <FBFriendPickerDelegate>


@property (strong, nonatomic) UIButton *selectedFriendsView;
@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;
@property (nonatomic, strong) NSArray *facebookFriendsArray;
@property (nonatomic, strong) UISearchBar *friendSearch;
@property (nonatomic, strong) UISearchController *friendSearchController;

- (void)fillTextBoxAndDismiss:(NSString *)text;

@end

@implementation AddPlayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.selectedFriendsView = [[UIButton alloc] initWithFrame:CGRectMake(40, 200, 300, 50)];
    [self.selectedFriendsView setTitle:@"Pick Friends" forState:UIControlStateNormal];
    self.selectedFriendsView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.selectedFriendsView];
    
    [self.selectedFriendsView addTarget:self action:@selector(pickFriendsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidUnload {
    self.selectedFriendsView = nil;
    self.friendPickerController = nil;
    
    [super viewDidUnload];
}

- (void)pickFriendsButtonClick:(id)sender {
    
    // FBSample logic
    // if the session is open, then load the data for our view controller
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"user_friends"]
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState state,
                                                          NSError *error) {
                                          if (error) {
                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:error.localizedDescription
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                              [alertView show];
                                          } else if (session.isOpen) {
                                              [self pickFriendsButtonClick:sender];
                                          }
                                      }];
        return;
    }
    
    if (self.friendPickerController == nil) {
        // Create friend picker, and get data loaded into it.
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
        self.friendPickerController.title = @"Pick Friends";
        self.friendPickerController.delegate = self;
        
        self.friendSearchController = [[UISearchController alloc] initWithSearchResultsController: nil];
        self.friendSearch = [UISearchBar new];
        [self.friendSearch sizeToFit];
        self.friendPickerController.tableView.tableHeaderView = self.friendSearchController.searchBar;
    }
    
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
    
    
    

    
    [self presentViewController:self.friendPickerController animated:YES completion:nil];
    
//    FBRequest* friendsRequest = [FBRequest requestWithGraphPath:@"me/friends?fields=picture,name,username,location,first_name,last_name" parameters:nil HTTPMethod:@"GET"];
//    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection, NSDictionary* result, NSError *error) {
//        //store result into facebookFriendsArray
//        self.facebookFriendsArray = [result objectForKey:@"data"];
//    }];
}

- (void)facebookViewControllerDoneWasPressed:(id)sender {
    NSMutableString *text = [[NSMutableString alloc] init];
    
    // we pick up the users from the selection, and create a string that we use to update the text view
    // at the bottom of the display; note that self.selection is a property inherited from our base class
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        if ([text length]) {
            [text appendString:@", "];
        }
        [text appendString:user.name];
    }
    
    [self fillTextBoxAndDismiss:text.length > 0 ? text : @"<None>"];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender {
    [self fillTextBoxAndDismiss:@"<Cancelled>"];
}

- (void)fillTextBoxAndDismiss:(NSString *)text {
    //self.selectedFriendsView.text = text;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
