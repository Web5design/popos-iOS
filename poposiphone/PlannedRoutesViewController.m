#import "PlannedRoutesViewController.h"
#import "RouteListViewController.h"
#import "BigPanelButton.h"

@interface PlannedRoutesViewController ()
@property (weak, nonatomic) IBOutlet BigPanelButton *kidsCornerButton;
@property (strong, nonatomic, readwrite) RouteRepository *routeRepository;
@end

@implementation PlannedRoutesViewController

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
    self.kidsCornerButton.highlightedColor = [UIColor colorWithRed:233.0/255 green:83.0/255 blue:85.0/255 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonKidsCornerTapped:(id)sender {
    UIViewController *routeListViewController = [[RouteListViewController alloc] initWithRouteRepository:self.routeRepository];
    [self.navigationController pushViewController:routeListViewController animated:YES];
}

@end
