//
//  JDRootTabViewController.m
//  
//
//  Created by mervin on 2017/8/14.
//
//

#import "JDRootTabViewController.h"
#import <RDVTabBarItem.h>
#import "JDBaseNavigationController.h"
#import "Posts_RootViewController.h"
#import "Pic_ViewController.h"
#import "RKSwipeBetweenViewControllers.h"
#import "Me_RootViewController.h"
#import "PostViewModel.h"
#import "Pic_ViewModel.h"
#import "MeSettingViewModel.h"

@interface JDRootTabViewController ()<RDVTabBarControllerDelegate>

@property (nonatomic, strong) PostViewModel *post_ViewModel;
@property (nonatomic, strong) Pic_ViewModel *pic_ViewModel;
@property(nonatomic, strong) Pic_ViewModel *xxoo_ViewModel;
@property(nonatomic, strong) Pic_ViewModel *duan_ViewModel;
@property(nonatomic, strong) MeSettingViewModel *set_ViewModel;

@property (nonatomic, assign) NSInteger clickCount;
@property (nonatomic, assign) NSInteger preClick;

@end

@implementation JDRootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewModels];
    [self setupViewControllers];
}

- (void)initViewModels {
    self.post_ViewModel = [[PostViewModel alloc] init];
    
    self.pic_ViewModel = [[Pic_ViewModel alloc] init];
    self.pic_ViewModel.type = PicTypePIC;
    
    self.xxoo_ViewModel = [[Pic_ViewModel alloc] init];
    self.xxoo_ViewModel.type = PicTypeXXOO;
    
    self.duan_ViewModel = [[Pic_ViewModel alloc] init];
    self.duan_ViewModel.type = PicTypeJoke;
    
    self.set_ViewModel = [MeSettingViewModel new];
    
}


- (void) setupViewControllers {
    // 新鲜事
    Posts_RootViewController *post_ctrl = [[Posts_RootViewController alloc] initWithViewModel:self.post_ViewModel];
    UINavigationController *home_nav = [[JDBaseNavigationController alloc] initWithRootViewController:post_ctrl];
    
    // 无聊图 | 妹子图
    RKSwipeBetweenViewControllers *sp_nav = [RKSwipeBetweenViewControllers newSwipeBetweenViewControllers];
    Pic_ViewController *pic_ctrl = [[Pic_ViewController alloc] initWithViewModel:self.pic_ViewModel];
    Pic_ViewController *xxoo_ctrl = [[Pic_ViewController alloc] initWithViewModel:self.xxoo_ViewModel];
    sp_nav.buttonText = @[@"无聊图", @"妹子图"];
    [sp_nav.viewControllerArray addObjectsFromArray:@[pic_ctrl, xxoo_ctrl]];
    
    // 段子
    Pic_ViewController *duan_ctrl = [[Pic_ViewController alloc] initWithViewModel:self.duan_ViewModel];
    UINavigationController *duan_nav = [[JDBaseNavigationController alloc] initWithRootViewController:duan_ctrl];
    
    // 设置
    Me_RootViewController *me_Ctrl = [[Me_RootViewController alloc] initWithViewModel:self.set_ViewModel];
    UINavigationController *me_nav = [[JDBaseNavigationController alloc] initWithRootViewController:me_Ctrl];
    
    [self setViewControllers:@[home_nav, sp_nav, duan_nav, me_nav]];
    [self customizeTabBarForController];
    self.delegate = self;
}

- (void) customizeTabBarForController {
    UIImage *backgroundImage = [UIImage imageWithColor:kColorNavBG];
    NSArray *tabBarItemImages = @[@"home", @"home", @"home", @"home", @"me"];
    NSArray *tabBarItemTitles = @[@"新鲜事", @"无聊图", @"段子", @"我"];
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
        item.selectedTitleAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0x76808E"]};
        
    }
}


#pragma mark RDVTabBarControllerDelegate

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}
#pragma mark - RDVTabBarDelegate

- (void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index {
    [super tabBar:tabBar didSelectItemAtIndex:index];
    
}

@end
