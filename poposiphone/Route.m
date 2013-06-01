#import "Route.h"
#import "Space.h"

@interface Route ()
@property (strong, nonatomic, readwrite) NSArray *coordinates;
@property (strong, nonatomic, readwrite) NSString *identifier;
@end

@implementation Route
- (id)initWithIdentifier:(NSString *)identifier coordinates:(NSArray *)coordinates miles:(NSString *)miles {
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.coordinates = coordinates;
        self.miles = miles;
    }
    return self;
}

- (NSString *)firstToLastName {
    NSString *firstSpaceName = ((Space *)self.spaces[0]).identifier;
    NSString *lastSpaceName = ((Space *)self.spaces[self.spaces.count - 1]).identifier;
    return [NSString stringWithFormat:@"%@ to %@", firstSpaceName, lastSpaceName];
}
@end
