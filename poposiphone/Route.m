#import "Route.h"

@interface Route ()
@property (strong, nonatomic, readwrite) NSArray *coordinates;
@property (strong, nonatomic, readwrite) NSString *identifier;
@end

@implementation Route
- (id)initWithIdentifier:(NSString *)identifier coordinates:(NSArray *)coordinates {
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.coordinates = coordinates;
    }
    return self;
}
@end
