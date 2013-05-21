#import "MapViewController.h"
#import <MapBox/MapBox.h>
#import <MapBox/RMFoundation.h>
#import <MapBox/RMMarker.h>
#import "SpaceViewController.h"

@interface MapViewController ()
@property (strong, nonatomic, readwrite) SpaceRepository *spaceRepository;
@end

@implementation MapViewController

NSString *kStamenAttribution = @"Map tiles by <a href=\"http://stamen.com\">Stamen Design</a>, under <a href=\"http://creativecommons.org/licenses/by/3.0\">CC BY 3.0</a>. Data by <a href=\"http://openstreetmap.org\">OpenStreetMap</a>, under <a href=\"http://creativecommons.org/licenses/by-sa/3.0\">CC BY SA</a>.";

- (id)initWithSpaceRepository:(SpaceRepository *)spaceRepository {
    self = [super init];
    if (self) {
        self.spaceRepository = spaceRepository;
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
        annotation.userInfo = space;
        [mapView addAnnotation:annotation];
    }
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    RMMarker *marker = [[RMMarker alloc] initWithMapBoxMarkerImage];
    marker.canShowCallout = YES;
    UIButton *theButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    marker.rightCalloutAccessoryView = theButton;
    
    return marker;
}

- (void)tapOnCalloutAccessoryControl:(UIControl *)control forAnnotation:(RMAnnotation *)annotation onMap:(RMMapView *)map
{
    SpaceViewController *spaceController = [[SpaceViewController alloc] initWithSpace:annotation.userInfo];
    [self.navigationController pushViewController:spaceController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
