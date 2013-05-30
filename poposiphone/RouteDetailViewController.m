#import "RouteDetailViewController.h"
#import "Space.h"
#import "SpaceViewController.h"
#import <MapBox/MapBox.h>

@interface RouteDetailViewController ()
@property (strong, nonatomic) Route *route;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet RMMapView *mapView;
@end

@implementation RouteDetailViewController

- (id)initWithRoute:(Route *)route {
    self = [super init];
    if (self) {
        self.route = route;
    }
    return self;
}

- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    RMMapBoxSource *onlineSource = [[RMMapBoxSource alloc] initWithMapID:@"cdawson.map-0ymh0yul"];
    self.mapView.tileSource = onlineSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.route.spaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"spaceCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"spaceCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Space *space = self.route.spaces[indexPath.row];
    cell.textLabel.text = space.identifier;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Space *space = self.route.spaces[indexPath.row];
    SpaceViewController *spaceView = [[SpaceViewController alloc] initWithSpace:space];
    [self.navigationController pushViewController:spaceView animated:YES];
}

@end
