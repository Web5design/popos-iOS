#import "RouteRepository.h"
#import <MapKit/MapKit.h>

@interface RouteRepository ()
@property (strong, nonatomic, readwrite) NSArray *routes;
@end

@implementation RouteRepository

- (id)init {
    self = [super init];
    if (self) {
        self.routes = @[];
    }
    return self;
}

- (void)populateFromGeoJSONFile:(NSString *)pathToFile {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *jsonFile = [resourcePath stringByAppendingPathComponent:pathToFile];
    NSData *data = [NSData dataWithContentsOfFile:jsonFile];
    NSError *charError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&charError];

    self.routes = @[[RouteRepository routeFromGeoJSON:dict]];
}

+ (Route *)routeFromGeoJSON:(NSDictionary *)json {
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSArray *pair in json[@"coordinates"]) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([pair[1] floatValue],[pair[0] floatValue]);
        [arr addObject:[NSValue valueWithBytes:&coordinate objCType:@encode(CLLocationCoordinate2D)]];
    }
    return [[Route alloc] initWithCoordinates:arr];
}
@end
