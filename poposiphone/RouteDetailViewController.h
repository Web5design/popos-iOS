#import <UIKit/UIKit.h>
#import "MapBox.h"
#import "Route.h"

@interface RouteDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RMMapViewDelegate>
- (id)initWithRoute:(Route *)route;
@end
