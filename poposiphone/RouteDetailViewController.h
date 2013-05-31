#import <UIKit/UIKit.h>
#import <MapBox/MapBox.h>
#import "Route.h"

@interface RouteDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RMMapViewDelegate>
- (id)initWithRoute:(Route *)route;
@end
