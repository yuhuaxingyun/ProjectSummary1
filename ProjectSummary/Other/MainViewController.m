//
//  MainViewController.m
//  XHongShu
//
//  Created by 周陆洲 on 16/5/24.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MainViewController.h"
#import "MyNavigationController.h"
#import "ViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.barTintColor = TabBarColor;
    
    [self createUI];
//    [self createTabBar];
   
    self.tabBar.hidden = YES;
}

#pragma mark NavigationBar
-(void)createUI
{
    //主页
    ViewController *homepageVC = [[ViewController alloc] init];
    MyNavigationController *homepageNav = [[MyNavigationController alloc] initWithRootViewController:homepageVC];

    self.viewControllers = @[homepageNav];
    
}


#pragma mark TabBar
-(void)createTabBar
{
    NSArray *titleArr = @[@"主页",@"发现",@"购买",@"消息",@"我"];
    
    NSArray *unselectedIconArr = @[@"tab_home~iphone",@"tab_search~iphone",@"tab_store~iphone",@"tab_msn~iphone",@"tab_me~iphone"];
    NSArray *selectedIconArr = @[@"tab_home_h~iphone",@"tab_search_h~iphone",@"tab_store_h~iphone",@"tab_msn_h~iphone",@"tab_me_h~iphone"];
    
    for (NSInteger i = 0;i < self.tabBar.items.count;i ++) {
        UITabBarItem *item = self.tabBar.items[i];
        
        UIImage *unselectedImage = [[UIImage imageNamed:unselectedIconArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage *selectedImage = [[UIImage imageNamed:selectedIconArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        NSString *title = titleArr[i];
        
        item = [item initWithTitle:title image:unselectedImage selectedImage:selectedImage];
        
        
        NSDictionary *dicNormal = @{NSForegroundColorAttributeName:[UIColor darkGrayColor]};
        NSDictionary *dicSelected = @{NSForegroundColorAttributeName:[UIColor redColor]};
        
        [item setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
        [item setTitleTextAttributes:dicSelected forState:UIControlStateSelected];
    }
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
