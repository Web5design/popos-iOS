#import "Route.h"

@interface Route ()
@property (strong, nonatomic, readwrite) NSArray *coordinates;
@end

@implementation Route
- (id)initWithCoordinates:(NSArray *)coordinates {
    self = [super init];
    if (self) {
        self.coordinates = coordinates;
    }
    return self;
}
@end
