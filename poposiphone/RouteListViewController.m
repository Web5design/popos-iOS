#import "RouteListViewController.h"
#import "RouteDetailViewController.h"

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Route *route = self.routeRepository.routes[indexPath.row];
    RouteDetailViewController *routeDetail = [[RouteDetailViewController alloc] initWithRoute:route];
    [self.navigationController pushViewController:routeDetail animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.routeRepository.routes count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"routeCell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"routeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.imageView setImage:[UIImage imageNamed:@"CellCircle.png"]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 20, 20)];
        label.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14.0];
        label.textColor = [UIColor colorWithWhite:0.25 alpha:1.0];
        label.backgroundColor = [UIColor clearColor];
        [cell.imageView addSubview:label];
        cell.textLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:18.0];
        cell.detailTextLabel.text = @"Distance: 1.0 Miles";
        cell.detailTextLabel.font = [UIFont fontWithName:@"GillSans-Light" size:12.0];
    }
    
    UILabel *label = cell.imageView.subviews[0];
    label.text = [NSString stringWithFormat:@"%d", indexPath.row+1];
    
    Route *route = self.routeRepository.routes[indexPath.row];    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ STREET TO FAKE STREET", route.identifier];
    return cell;
}

@end
