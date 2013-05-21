#import <CoreLocation/CoreLocation.h>

@interface Space : NSObject
@property (strong, nonatomic, readonly) NSString *identifier;
@property (assign, nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic, readonly) NSString *imageUrl;

- (id)initWithIdentifier:(NSString *)identifier coordinate:(CLLocationCoordinate2D)coordinate imageUrl:(NSString *)imageUrl;
@end
