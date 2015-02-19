//
//  FacebookViewController.m
//  DiscGolf
//
//  Created by Daniel Bladh on 2/11/15.
//  Copyright (c) 2015 Daniel Bladh. All rights reserved.
//

#import "FacebookViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "AddPlayersViewController.h"
#import "AddCourseViewController.h"

@interface FacebookViewController () <FBLoginViewDelegate>

@property (strong, nonatomic) FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UIImageView * backgroundImage;
@property (strong, nonatomic) FBLoginView *loginView;


@end

@implementation FacebookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackGroundImage"]];
    self.backgroundImage.frame = self.view.frame;
    [self.view addSubview: self.backgroundImage];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 600);
    loginView.delegate = self;
    [self.view addSubview:loginView];
    
    self.loginView = loginView;
    
  
    self.startGameButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 200, 300, 50)];
    [self.startGameButton setTitle:@"Create Game" forState:UIControlStateNormal];
    [self.view addSubview: self.startGameButton];
    
    self.addCourseButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 275, 300, 50)];
    [self.addCourseButton setTitle:@"Add Course" forState:UIControlStateNormal];
    [self.view addSubview: self.addCourseButton];
    
    self.startGameButton.backgroundColor = [UIColor blueColor];
    self.addCourseButton.backgroundColor = [UIColor blueColor];
    
    [self.startGameButton addTarget:self action:@selector(startGameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.startGameButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.addCourseButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.loginView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *facebookViewControllerDictionary = NSDictionaryOfVariableBindings(_startGameButton, _addCourseButton,_loginView);
    
    NSArray *startGameButtonConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==40)-[_startGameButton]-(==40)-|" options:0 metrics:nil views:facebookViewControllerDictionary];
    
    NSArray *addCourseButtonConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==40)-[_addCourseButton]-(==40)-|" options:0 metrics:nil views:facebookViewControllerDictionary];
    
    NSArray *loginViewConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==60)-[_loginView]-(==60)-|" options:0 metrics:nil views:facebookViewControllerDictionary];
    
    NSArray *verConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(==200)-[_startGameButton(==70)]-[_addCourseButton(==70)]-[_loginView(==55)]" options:0 metrics:nil views:facebookViewControllerDictionary];
    
    
    
    [self.view addConstraints:startGameButtonConstraints];
    [self.view addConstraints:addCourseButtonConstraints];
    [self.view addConstraints:loginViewConstraints];
    
    [self.view addConstraints:verConstraints];
    
}




-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    self.statusLabel.text = @"";
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 565, 200, 50)];
    [self.view addSubview: self.statusLabel];
    
    self.startGameButton.backgroundColor = [UIColor blueColor];
    self.addCourseButton.backgroundColor = [UIColor blueColor];
    
    self.startGameButton.enabled = YES;
    self.addCourseButton.enabled = YES;
    
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
user:(id<FBGraphUser>)user {
    
    self.profilePictureView = [[FBProfilePictureView alloc] initWithFrame:CGRectMake(320, 70, 45, 45)];
    self.profilePictureView.profileID = user.objectID;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 75, 200, 30)];
    //self.nameLabel.text = user.name;
    
    [self.view addSubview: self.profilePictureView];
    
    self.profilePictureView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *facebookViewControllerDictionary = NSDictionaryOfVariableBindings(_profilePictureView);
    
    NSArray *profilePictureViewConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_profilePictureView(==55)]-(15)-|" options:0 metrics:nil views:facebookViewControllerDictionary];
    
     NSArray *verticleProfilePictureViewConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(80)-[_profilePictureView(==55)]" options:0 metrics:nil views:facebookViewControllerDictionary];
    
    [self.view addConstraints:profilePictureViewConstraints];
    [self.view addConstraints:verticleProfilePictureViewConstraints];

    //[self.view addSubview: self.nameLabel];
    
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
//    self.statusLabel.text = @"You Logged Out";
    
    self.profilePictureView.profileID = nil;
    //self.nameLabel.text = nil;
    
    self.startGameButton.backgroundColor = [UIColor grayColor];
    self.addCourseButton.backgroundColor = [UIColor grayColor];
    
    self.startGameButton.enabled = NO;
    self.addCourseButton.enabled = NO;
    
    
}

-(void)startGameButtonPressed:(id)sender{
    [self.navigationController pushViewController:[AddPlayersViewController new] animated:YES];
}






- (void)viewDidUnload {
  
    [super viewDidUnload];
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
