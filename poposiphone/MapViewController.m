//
//        MapViewController.m
//        poposiphone
//
//        Created by Brandon Liu on 5/20/13.
//        Copyright (c) 2013 bdon. All rights reserved.
//

#import "MapViewController.h"
#import <MapBox/MapBox.h>
#import <MapBox/RMFoundation.h>
#import <MapBox/RMMarker.h>

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
                self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
                if (self) {
                                // Custom initialization
                }
                return self;
}


- (void)viewDidLoad
{
                [super viewDidLoad];

                NSString *stamenAttribution = @"Map tiles by <a href=\"http://stamen.com\">Stamen Design</a>, under <a href=\"http://creativecommons.org/licenses/by/3.0\">CC BY 3.0</a>. Data by <a href=\"http://openstreetmap.org\">OpenStreetMap</a>, under <a href=\"http://creativecommons.org/licenses/by-sa/3.0\">CC BY SA</a>.";

                NSDictionary *tileJsonDict = @{ @"tilejson": @"2.0.0",
                                                                                                                                        @"tiles": @[
                                                                                                                                                                        @"http://tile.stamen.com/watercolor/{z}/{x}/{y}.jpg"],
                                                                                                                                        @"minzoom":@(1),
                                                                                                                                        @"maxzoom":@(16),
                                                                                                                                        @"attribution":stamenAttribution};

                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tileJsonDict
                                                                                                                                                                                                                         options:NSJSONWritingPrettyPrinted
                                                                                                                                                                                                                                 error:&error];
                NSString *tileJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

                RMMapBoxSource *onlineSource = [[RMMapBoxSource alloc] initWithTileJSON:tileJSON];
                RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:onlineSource];

                mapView.zoom = 17;
                mapView.centerCoordinate = CLLocationCoordinate2DMake(37.7920,-122.399);
                mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                [self.view addSubview:mapView];
}

- (void)didReceiveMemoryWarning
{
                [super didReceiveMemoryWarning];
                // Dispose of any resources that can be recreated.
}

@end
