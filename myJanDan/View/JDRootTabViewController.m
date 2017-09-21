//
//  JDRootTabViewController.m
//  
//
//  Created by mervin on 2017/8/14.
//
//

#import "JDRootTabViewController.h"
#import "JDBaseNavigationController.h"
#import "Posts_RootViewController.h"
#import "Pic_ViewController.h"
#import "RKSwipeBetweenViewControllers.h"
#import "Me_RootViewController.h"
#import "PostViewModel.h"
#import "Pic_ViewModel.h"
#import "MeSettingViewModel.h"
#import "JUIHelper.h"

@interface JDRootTabViewController ()

@property (nonatomic, strong) PostViewModel *post_ViewModel;
@property (nonatomic, strong) Pic_ViewModel *pic_ViewModel;
@property(nonatomic, strong) Pic_ViewModel *xxoo_ViewModel;
@property(nonatomic, strong) Pic_ViewModel *duan_ViewModel;
@property(nonatomic, strong) MeSettingViewModel *set_ViewModel;

@property (nonatomic, assign) NSInteger clickCount;
@property (nonatomic, assign) NSInteger preClick;

@end

@implementation JDRootTabViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self __initialized];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self __initialized];
    }
    return self;
}

- (void)__initialized {
    self.tabBar.tintColor =kColorNavTitle;
    self.tabBar.backgroundColor = kColorNavBG;
    self.tabBar.translucent = NO;
    
}

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
    UIImage *imgHOME = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    /// 新鲜事
    Posts_RootViewController *post_ctrl = [[Posts_RootViewController alloc] initWithViewModel:self.post_ViewModel];
    post_ctrl.hidesBottomBarWhenPushed = NO;
    UINavigationController *home_nav = [[JDBaseNavigationController alloc] initWithRootViewController:post_ctrl];
    home_nav.tabBarItem = [JUIHelper tabBarItemWithTitle:@"新鲜事"
                                                   image:imgHOME
                                           selectedImage:imgHOME
                                                     tag:0];
    
    /// 无聊图 | 妹子图
    RKSwipeBetweenViewControllers *sp_nav = [RKSwipeBetweenViewControllers newSwipeBetweenViewControllers];
    Pic_ViewController *pic_ctrl = [[Pic_ViewController alloc] initWithViewModel:self.pic_ViewModel];
    pic_ctrl.hidesBottomBarWhenPushed = NO;
    Pic_ViewController *xxoo_ctrl = [[Pic_ViewController alloc] initWithViewModel:self.xxoo_ViewModel];
    xxoo_ctrl.hidesBottomBarWhenPushed = NO;
    sp_nav.buttonText = @[@"无聊图", @"妹子图"];
    [sp_nav.viewControllerArray addObjectsFromArray:@[pic_ctrl, xxoo_ctrl]];
    sp_nav.tabBarItem = [JUIHelper tabBarItemWithTitle:@"无聊图"
                                                   image:imgHOME
                                           selectedImage:imgHOME
                                                     tag:1];
    
    /// 段子
    Pic_ViewController *duan_ctrl = [[Pic_ViewController alloc] initWithViewModel:self.duan_ViewModel];
    duan_ctrl.hidesBottomBarWhenPushed = NO;
    UINavigationController *duan_nav = [[JDBaseNavigationController alloc] initWithRootViewController:duan_ctrl];
    duan_nav.tabBarItem = [JUIHelper tabBarItemWithTitle:@"段子"
                                                   image:imgHOME
                                           selectedImage:imgHOME
                                                     tag:2];
    /// 设置
    Me_RootViewController *me_Ctrl = [[Me_RootViewController alloc] initWithViewModel:self.set_ViewModel];
    me_Ctrl.hidesBottomBarWhenPushed = NO;
    UINavigationController *me_nav = [[JDBaseNavigationController alloc] initWithRootViewController:me_Ctrl];
    me_nav.tabBarItem = [JUIHelper tabBarItemWithTitle:@"设置"
                                                   image:imgHOME
                                           selectedImage:imgHOME
                                                     tag:3];
    
    [self setViewControllers:@[home_nav, sp_nav, duan_nav, me_nav]];

}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    DebugLog(@"%ld", item.tag);
}

@end
