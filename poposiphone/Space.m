#import "Space.h"

@interface Space ()
@property (strong, nonatomic, readwrite) NSString *identifier;
@property (assign, nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic, readwrite) NSString *imageUrl;
@end

@implementation Space
- (id)initWithIdentifier:(NSString *)identifier coordinate:(CLLocationCoordinate2D)coordinate imageUrl:(NSString *)imageUrl {
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.coordinate = coordinate;
        self.imageUrl = imageUrl;
    }
    return self;
}
@end
