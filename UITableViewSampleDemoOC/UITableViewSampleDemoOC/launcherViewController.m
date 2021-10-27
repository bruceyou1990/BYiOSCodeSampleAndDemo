//
//  launcherViewController.m
//  UITableViewSampleDemoOC
//
//  Created by BruceYou on 2021/10/16.
//

#import "launcherViewController.h"

@interface launcherViewController ()

@end

@implementation launcherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"启动页";

//    [self createTabBarController];
}


- (void)creatAeraers {
    [self setupTabBar];
    // 添加子控制器
    [self setupChildVC:@"精华" andImage:@"tarBarCar" andSelectImage:@"tarBarCar"];
    [self setupChildVC:@"新帖" andImage:@"tarBarCar" andSelectImage:@"tarBarCar"];
    [self setupChildVC:@"关注" andImage:@"tarBarCar" andSelectImage:@"tarBarCar"];
    [self setupChildVC:@"我" andImage:@"tarBarCar" andSelectImage:@"tarBarCar"];
    
}

/**
 *tabBar基本设置
 */
- (void)setupTabBar{
        // 通过appearance统一设置UITabbarItem的文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12.0];  // 设置文字大小
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];  // 设置文字的前景色
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];  // 设置appearance
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVC:(NSString * )title andImage:(NSString * )image andSelectImage:(NSString *)selectImage{
    UIViewController * VC = [[UIViewController alloc]init];
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:image];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    VC.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:VC];
}


@end
