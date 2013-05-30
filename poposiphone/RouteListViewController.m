#import "RouteListViewController.h"

@interface RouteListViewController ()
@property (strong, nonatomic, readwrite) RouteRepository *routeRepository;
@end

@implementation RouteListViewController

- (id)initWithRouteRepository:(RouteRepository *)routeRepository {
    self = [super init];
    if (self) {
        self.routeRepository = routeRepository;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
