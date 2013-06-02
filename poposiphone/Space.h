#import <CoreLocation/CoreLocation.h>

@interface Space : NSObject
@property (strong, nonatomic, readonly) NSString *identifier;
@property (assign, nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic, readonly) NSString *imageUrl;
@property (strong, nonatomic, readonly) NSString *description;
@property (strong, nonatomic, readonly) NSString *routeIdentifier;
@property (assign, readonly) BOOL food;

- (id)initWithIdentifier:(NSString *)identifier coordinate:(CLLocationCoordinate2D)coordinate imageUrl:(NSString *)imageUrl description:(NSString *)description routeIdentifier:(NSString *)routeIdentifier food:(BOOL)food;
@end
