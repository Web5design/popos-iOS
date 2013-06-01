#import "AppDelegate.h"
#import "MapViewController.h"
#import "RouteListViewController.h"
#import "SpaceRepository.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBarAppearance.png"] forBarMetrics:UIBarMetricsDefault];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBarAppearance.png"]];
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                UITextAttributeTextColor: [UIColor whiteColor],
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                     UITextAttributeFont: [UIFont fontWithName:@"Futura-CondensedMedium" size:20.0f]
     }];
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont:[UIFont fontWithName:@"Futura-Medium" size:12.0f]} forState:UIControlStateNormal];
        
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBarController;

    SpaceRepository *spaceRepository = [[SpaceRepository alloc] init];
    [spaceRepository populateFromGeoJSONFile:@"sfpopos.geojson"];

    RouteRepository *routeRepository = [[RouteRepository alloc] init];
    [routeRepository populateFromGeoJSONFile:@"sfpopos-routes-collection.geojson"];
    [routeRepository addSpaces:spaceRepository];

    UIViewController *mapViewController = [[MapViewController alloc] initWithSpaceRepository:spaceRepository routeRepository:routeRepository];
    UINavigationController *mapNavController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    UIViewController *routeListViewController = [[RouteListViewController alloc] initWithRouteRepository:routeRepository];
    routeListViewController.title = @"PLANNED ROUTES";
    
    UINavigationController *routeNavController = [[UINavigationController alloc] initWithRootViewController:routeListViewController];
    
    tabBarController.viewControllers = @[mapNavController, routeNavController];

    UITabBarItem *tabBarItem1 = tabBarController.tabBar.items[0];
    tabBarController.tabBar.selectedImageTintColor = nil;
    tabBarItem1.title = @"map";
    
    tabBarItem1.image = [UIImage imageNamed:@"MapMenuIcon.png"];

    UITabBarItem *tabBarItem2 = tabBarController.tabBar.items[1];
    tabBarItem2.title = @"planned routes";
    tabBarItem2.image = [UIImage imageNamed:@"PathMenuIcon.png"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
