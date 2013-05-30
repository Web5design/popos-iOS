#import "RouteListViewController.h"

@interface RouteListViewController ()
@property (strong, nonatomic, readwrite) RouteRepository *routeRepository;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.routeRepository.routes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"routeCell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"routeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Route *route = self.routeRepository.routes[indexPath.row];    
    cell.textLabel.text = route.identifier;
    return cell;
}

@end
