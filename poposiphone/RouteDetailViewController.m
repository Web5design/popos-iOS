#import "RouteDetailViewController.h"

@interface RouteDetailViewController ()
@property (strong, nonatomic) Route *route;
@end

@implementation RouteDetailViewController

- (id)initWithRoute:(Route *)route {
    self = [super init];
    if (self) {
        self.route = route;
    }
    return self;
}

@end
