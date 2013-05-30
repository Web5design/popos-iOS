#import <UIKit/UIKit.h>
#import "Route.h"

@interface RouteDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (id)initWithRoute:(Route *)route;
@end
