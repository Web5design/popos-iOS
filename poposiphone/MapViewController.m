#import "MapViewController.h"
#import "SpaceViewController.h"
#import "FilterViewController.h"

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

    RMMapBoxSource *onlineSource = [[RMMapBoxSource alloc] initWithMapID:@"cdawson.map-rfzl19el"];

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
    mapView.showsUserLocation = YES;


    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"FilterButton.png"] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(showFilters) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = filterButton;
}

- (void)showFilters {
    UIViewController *filterController = [[FilterViewController alloc] init];
    [self presentViewController:filterController animated:YES completion:nil];
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{

    if ([annotation.userInfo[@"type"] isEqualToString:@"space"]) {
        RMMarker *marker = [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:@"Marker.png"]];
        marker.canShowCallout = YES;
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        marker.rightCalloutAccessoryView = theButton;
        
        return marker;
    } else {
        // It's the current location marker
        UIImage *testimage = [UIImage imageNamed:@"BlueDot.png"];
        return [[RMMarker alloc] initWithUIImage:testimage];
    }

    return nil;
}

- (void)mapView:(RMMapView *)mapView didSelectAnnotation:(RMAnnotation *)annotation {
    if ([annotation.userInfo[@"type"] isEqualToString:@"space"]) {
        [((RMMarker *)annotation.layer) replaceUIImage:[UIImage imageNamed:@"Marker_highlight.png"]];
    }
}

- (void)mapView:(RMMapView *)mapView didDeselectAnnotation:(RMAnnotation *)annotation {
    if ([annotation.userInfo[@"type"] isEqualToString:@"space"]) {
        [((RMMarker *)annotation.layer) replaceUIImage:[UIImage imageNamed:@"Marker.png"]];
    }
}

- (void)tapOnCalloutAccessoryControl:(UIControl *)control forAnnotation:(RMAnnotation *)annotation onMap:(RMMapView *)map
{
    SpaceViewController *spaceController = [[SpaceViewController alloc] initWithSpace:annotation.userInfo[@"obj"]];
    [self.navigationController pushViewController:spaceController animated:YES];
}

@end
