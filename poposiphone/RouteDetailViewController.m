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
        self.title = self.route.identifier;
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
    CLLocationCoordinate2D southwest = CLLocationCoordinate2DMake(37.688, -122.5447);
    CLLocationCoordinate2D northeast = CLLocationCoordinate2DMake(37.827, -122.3531);
    [self.mapView setConstraintsSouthWest:southwest northEast:northeast];
    
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
}

- (void)viewWillAppear:(BOOL)animated {
    CLLocationCoordinate2D firstCoord;
    [self.route.coordinates[0] getValue:&firstCoord];
    self.mapView.centerCoordinate = firstCoord;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.route.spaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"spaceCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"spaceCell"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 20, 20)];
        label.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14.0];
        label.textColor = [UIColor colorWithWhite:0.25 alpha:1.0];
        label.backgroundColor = [UIColor clearColor];
        [cell.imageView addSubview:label];
        cell.textLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:18.0];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"cellArrowButton.png"];
        CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
        button.frame = frame;
        [button addTarget:self action:@selector(accessoryTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        
        button.backgroundColor = [UIColor clearColor];
        cell.accessoryView = button;
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
    self.mapView.centerCoordinate = space.coordinate;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    Space *space = self.route.spaces[indexPath.row];
    SpaceViewController *spaceView = [[SpaceViewController alloc] initWithSpace:space];
    [self.navigationController pushViewController:spaceView animated:YES];
}

- (void)accessoryTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    
    if (indexPath != nil)
    {
        [self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    if ([annotation.userInfo[@"type"] isEqualToString:@"route"]) {
        Route *route = (Route *)annotation.userInfo[@"obj"];
        RMShape *routeShape = [[RMShape alloc] initWithView:mapView];
        routeShape.scaleLineDash = NO;
        routeShape.lineColor = [UIColor colorWithRed:232.0/255 green:83.0/255 blue:85.0/255 alpha:1.0];
        routeShape.lineDashPhase = 10.0;
        routeShape.lineDashLengths = @[@(10.0)];
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
        return [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:@"Marker.png"]];
    }
}

@end
