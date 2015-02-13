//
//  FacebookViewController.m
//  DiscGolf
//
//  Created by Daniel Bladh on 2/11/15.
//  Copyright (c) 2015 Daniel Bladh. All rights reserved.
//

#import "FacebookViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ViewController.h"

@interface FacebookViewController () <FBLoginViewDelegate>

@property (strong, nonatomic) FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UIButton * startGameButton;
@property (strong, nonatomic) UIButton * addPlayerButton;

@end

@implementation FacebookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 600);
    loginView.delegate = self;
    [self.view addSubview:loginView];
    
    self.startGameButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 200, 300, 50)];
    [self.startGameButton setTitle:@"Create Game" forState:UIControlStateNormal];
    [self.view addSubview: self.startGameButton];
    
    self.addPlayerButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 275, 300, 50)];
    [self.addPlayerButton setTitle:@"Add Player" forState:UIControlStateNormal];
    [self.view addSubview: self.addPlayerButton];
    
    self.startGameButton.backgroundColor = [UIColor blueColor];
    self.addPlayerButton.backgroundColor = [UIColor blueColor];
    
    
    [self.startGameButton addTarget:self action:@selector(startGameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    

}


-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    self.statusLabel.text = @"";
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 565, 200, 50)];
    [self.view addSubview: self.statusLabel];
    
    self.startGameButton.backgroundColor = [UIColor blueColor];
    self.addPlayerButton.backgroundColor = [UIColor blueColor];
    
    self.startGameButton.enabled = YES;
    self.addPlayerButton.enabled = YES;

}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
user:(id<FBGraphUser>)user {
    
    self.profilePictureView = [[FBProfilePictureView alloc] initWithFrame:CGRectMake(320, 70, 45, 45)];
    self.profilePictureView.profileID = user.objectID;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 75, 200, 30)];
    //self.nameLabel.text = user.name;
    
    [self.view addSubview: self.profilePictureView];
    //[self.view addSubview: self.nameLabel];
    
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
//    self.statusLabel.text = @"You Logged Out";
    
    self.profilePictureView.profileID = nil;
    //self.nameLabel.text = nil;
    
    self.startGameButton.backgroundColor = [UIColor grayColor];
    self.addPlayerButton.backgroundColor = [UIColor grayColor];
    
    self.startGameButton.enabled = NO;
    self.addPlayerButton.enabled = NO;
}

-(void)startGameButtonPressed:(id)sender{
    [self.navigationController pushViewController:[ViewController new] animated:YES];
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
