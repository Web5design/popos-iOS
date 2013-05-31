#import "RouteDetailViewController.h"
#import "Space.h"
#import "SpaceViewController.h"

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
    self.mapView.delegate = self;
    self.mapView.showLogoBug = NO;
    self.mapView.draggingEnabled = NO;
    
    
    for (Space *space in self.route.spaces) {
        RMAnnotation *annotation = [RMAnnotation annotationWithMapView:self.mapView coordinate:space.coordinate andTitle:space.identifier];
        annotation.userInfo = @{@"type":@"space",@"obj":space};
        [self.mapView addAnnotation:annotation];
    }

    CLLocationCoordinate2D firstCoord;
    [self.route.coordinates[0] getValue:&firstCoord];
    RMAnnotation *annotation = [RMAnnotation annotationWithMapView:self.mapView coordinate:firstCoord andTitle:@"Route"];
    annotation.userInfo = @{@"type":@"route",@"obj":self.route};
    [self.mapView addAnnotation:annotation];
    
    self.mapView.centerCoordinate = firstCoord;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.route.spaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"spaceCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"spaceCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 20, 20)];
        label.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14.0];
        label.textColor = [UIColor colorWithWhite:0.25 alpha:1.0];
        label.backgroundColor = [UIColor clearColor];
        [cell.imageView addSubview:label];
        cell.textLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:18.0];
    }
    
    Space *space = self.route.spaces[indexPath.row];
    cell.textLabel.text = space.identifier;
    [cell.imageView setImage:[UIImage imageNamed:@"CellCircle.png"]];
    UILabel *label = cell.imageView.subviews[0]; // hackety hack
    label.text = [NSString stringWithFormat:@"%d", indexPath.row+1];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Space *space = self.route.spaces[indexPath.row];
    SpaceViewController *spaceView = [[SpaceViewController alloc] initWithSpace:space];
    [self.navigationController pushViewController:spaceView animated:YES];
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    if ([annotation.userInfo[@"type"] isEqualToString:@"route"]) {
        Route *route = (Route *)annotation.userInfo[@"obj"];
        RMShape *routeShape = [[RMShape alloc] initWithView:mapView];
        routeShape.scaleLineDash = NO;
        routeShape.lineColor = [UIColor redColor];
        routeShape.lineDashLengths = @[@(5.0)];
        routeShape.lineWidth = 2.0;

        BOOL moveTo = YES;
        for (NSValue *coordValue in route.coordinates) {
            CLLocationCoordinate2D coord;
            [coordValue getValue:&coord];
            if (moveTo) {
                [routeShape moveToCoordinate:coord];
            } else {
                [routeShape addLineToCoordinate:coord];
            }
            
            moveTo = NO;
        }
        return routeShape;
    } else if ([annotation.userInfo[@"type"] isEqualToString:@"space"]) {
        RMMarker *marker = [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:@"Marker.png"]];
        marker.canShowCallout = YES;
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        marker.rightCalloutAccessoryView = theButton;
        
        return marker;
    }
}

@end
