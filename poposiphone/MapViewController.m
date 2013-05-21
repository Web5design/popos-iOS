#import "MapViewController.h"
#import <MapBox/MapBox.h>
#import <MapBox/RMFoundation.h>
#import <MapBox/RMMarker.h>
#import "SpaceViewController.h"

@interface MapViewController ()
@property (strong, nonatomic, readwrite) SpaceRepository *spaceRepository;
@property (strong, nonatomic, readwrite) RouteRepository *routeRepository;
@end

@implementation MapViewController

NSString *kStamenAttribution = @"Map tiles by <a href=\"http://stamen.com\">Stamen Design</a>, under <a href=\"http://creativecommons.org/licenses/by/3.0\">CC BY 3.0</a>. Data by <a href=\"http://openstreetmap.org\">OpenStreetMap</a>, under <a href=\"http://creativecommons.org/licenses/by-sa/3.0\">CC BY SA</a>.";

- (id)initWithSpaceRepository:(SpaceRepository *)spaceRepository routeRepository:(RouteRepository *)routeRepository {
    self = [super init];
    if (self) {
        self.spaceRepository = spaceRepository;
        self.routeRepository = routeRepository;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *tileJsonDict = @{ @"tilejson": @"2.0.0",
                                    @"tiles": @[@"http://tile.stamen.com/watercolor/{z}/{x}/{y}.jpg"],
                                    @"minzoom":@(1),
                                    @"maxzoom":@(16),
                                    @"attribution":kStamenAttribution};
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tileJsonDict
                                            options:NSJSONWritingPrettyPrinted
                                            error:&error];
    NSString *tileJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    RMMapBoxSource *onlineSource = [[RMMapBoxSource alloc] initWithTileJSON:tileJSON];
    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:onlineSource];
    mapView.delegate = self;
    
    mapView.showLogoBug = NO;
    mapView.zoom = 17;
    mapView.centerCoordinate = CLLocationCoordinate2DMake(37.7920,-122.399);
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:mapView];
    
    for (Space *space in self.spaceRepository.spaces) {
        RMAnnotation *annotation = [RMAnnotation annotationWithMapView:mapView coordinate:space.coordinate andTitle:space.identifier];
        annotation.userInfo = @{@"type":@"space",@"obj":space};
        [mapView addAnnotation:annotation];
    }
    
    for (Route *route in self.routeRepository.routes) {
        CLLocationCoordinate2D firstCoord;
        [route.coordinates[0] getValue:&firstCoord];
        RMAnnotation *annotation = [RMAnnotation annotationWithMapView:mapView coordinate:firstCoord andTitle:@"Route"];
        annotation.userInfo = @{@"type":@"route",@"obj":route};
        [mapView addAnnotation:annotation];
    }
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    if ([annotation.userInfo[@"type"] isEqualToString:@"space"]) {
        RMMarker *marker = [[RMMarker alloc] initWithMapBoxMarkerImage];
        marker.canShowCallout = YES;
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        marker.rightCalloutAccessoryView = theButton;
        
        return marker;
    } else {
        // it's a Route
        Route *route = (Route *)annotation.userInfo[@"obj"];
        RMShape *routeShape = [[RMShape alloc] initWithView:mapView];
        [routeShape setLineColor:[UIColor redColor]];
        [routeShape setLineWidth:5.0];
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
    }
}

- (void)tapOnCalloutAccessoryControl:(UIControl *)control forAnnotation:(RMAnnotation *)annotation onMap:(RMMapView *)map
{
    SpaceViewController *spaceController = [[SpaceViewController alloc] initWithSpace:annotation.userInfo[@"space"]];
    [self.navigationController pushViewController:spaceController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
