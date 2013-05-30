#import "Space.h"

@interface Space ()
@property (strong, nonatomic, readwrite) NSString *identifier;
@property (assign, nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic, readwrite) NSString *imageUrl;
@property (strong, nonatomic, readwrite) NSString *description;
@property (strong, nonatomic, readwrite) NSString *routeIdentifier;
@end

@implementation Space
- (id)initWithIdentifier:(NSString *)identifier coordinate:(CLLocationCoordinate2D)coordinate imageUrl:(NSString *)imageUrl description:(NSString *)description routeIdentifier:(NSString *)routeIdentifier {
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.coordinate = coordinate;
        self.imageUrl = imageUrl;
        self.description = description;
        self.routeIdentifier = routeIdentifier;
    }
    return self;
}
@end
