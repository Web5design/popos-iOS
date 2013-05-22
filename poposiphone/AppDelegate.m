#import "AppDelegate.h"
#import "MapViewController.h"
#import "SpaceRepository.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBarController;

    SpaceRepository *spaceRepository = [[SpaceRepository alloc] init];
    [spaceRepository populateFromGeoJSONFile:@"sfpopos.geojson"];

    RouteRepository *routeRepository = [[RouteRepository alloc] init];
    [routeRepository populateFromGeoJSONFile:@"sfpopos-routes-collection.geojson"];
    
    UIViewController *mapViewController = [[MapViewController alloc] initWithSpaceRepository:spaceRepository routeRepository:routeRepository];
    UINavigationController *mapNavController = [[UINavigationController alloc] initWithRootViewController:mapViewController];

    tabBarController.viewControllers = @[mapNavController];

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
