#import "MapViewController.h"
#import "SpaceViewController.h"

@interface MapViewController ()
@property (strong, nonatomic, readwrite) SpaceRepository *spaceRepository;
@property (strong, nonatomic, readwrite) RouteRepository *routeRepository;
@end

@implementation MapViewController

- (id)initWithSpaceRepository:(SpaceRepository *)spaceRepository routeRepository:(RouteRepository *)routeRepository {
    self = [super init];
    if (self) {
        self.spaceRepository = spaceRepository;
        self.routeRepository = routeRepository;
        self.title = @"MAP";
    }
    return self;
}

- (void)showOfflineMessage {
    UILabel *isOffline = [[UILabel alloc] init];
    isOffline.text = @"Internet Connection Needed!";
    isOffline.backgroundColor = [UIColor clearColor];
    [isOffline sizeToFit];
    isOffline.font = [UIFont fontWithName:@"GillSans" size:14.0];
    isOffline.textColor = [UIColor whiteColor];
    isOffline.center = CGPointMake(160,200);
    [self.view addSubview:isOffline];
    isOffline.textAlignment = NSTextAlignmentCenter;
    self.view.backgroundColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:56/255.0 alpha:1.0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    RMMapBoxSource *onlineSource = [[RMMapBoxSource alloc] initWithMapID:@"cdawson.map-0ymh0yul"];

    if(onlineSource == nil) [self showOfflineMessage];

    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:onlineSource];
    mapView.delegate = self;
    mapView.showLogoBug = NO;
    mapView.zoom = 17;
    mapView.centerCoordinate = CLLocationCoordinate2DMake(37.7920,-122.399);
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    CLLocationCoordinate2D southwest = CLLocationCoordinate2DMake(37.688, -122.5447);
    CLLocationCoordinate2D northeast = CLLocationCoordinate2DMake(37.827, -122.3531);
    [mapView setConstraintsSouthWest:southwest northEast:northeast];
    [self.view addSubview:mapView];
    
    for (Space *space in self.spaceRepository.spaces) {
        RMAnnotation *annotation = [RMAnnotation annotationWithMapView:mapView coordinate:space.coordinate andTitle:space.identifier];
        annotation.userInfo = @{@"type":@"space",@"obj":space};
        [mapView addAnnotation:annotation];
    }
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    if ([annotation.userInfo[@"type"] isEqualToString:@"space"]) {
        RMMarker *marker = [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:@"Marker.png"]];
        marker.canShowCallout = YES;
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        marker.rightCalloutAccessoryView = theButton;
        
        return marker;
    }
}

- (void)mapView:(RMMapView *)mapView didSelectAnnotation:(RMAnnotation *)annotation {
    [((RMMarker *)annotation.layer) replaceUIImage:[UIImage imageNamed:@"Marker_highlight.png"]];
}

- (void)mapView:(RMMapView *)mapView didDeselectAnnotation:(RMAnnotation *)annotation {
    [((RMMarker *)annotation.layer) replaceUIImage:[UIImage imageNamed:@"Marker.png"]];
}

- (void)tapOnCalloutAccessoryControl:(UIControl *)control forAnnotation:(RMAnnotation *)annotation onMap:(RMMapView *)map
{
    SpaceViewController *spaceController = [[SpaceViewController alloc] initWithSpace:annotation.userInfo[@"obj"]];
    [self.navigationController pushViewController:spaceController animated:YES];
}

@end
