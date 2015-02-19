//
//  ViewController.m
//  DiscGolf
//
//  Created by Daniel Bladh on 2/10/15.
//  Copyright (c) 2015 Daniel Bladh. All rights reserved.
//

#import "AddCourseViewController.h"
#import "AddPlayersViewController.h"
#import "ChoosePlayersViewController.h"
#import "HistoryViewController.h"
#import "FacebookViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AddCourseViewController ()

@property (nonatomic, strong) UITabBarController * tabBarController;

@end

@implementation AddCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.tabBarController = [UITabBarController new];
//    AddPlayersViewController * apvc =[AddPlayersViewController alloc];
//    apvc.tabBarItem.title = @"Add Players";
//    ChoosePlayersViewController * cpvc =[ChoosePlayersViewController alloc];
//    cpvc.tabBarItem.title = @"New Game";
//    HistoryViewController *hvc =[HistoryViewController alloc];
//    self.tabBarItem.title = @"History";
//    self.tabBarController.viewControllers = @[apvc, cpvc, hvc];

    //[self.navigationController pushViewController:self.tabBarController animated:YES];

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
