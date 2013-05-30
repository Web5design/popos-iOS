#import "RouteRepository.h"

@interface RouteListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
- (id)initWithRouteRepository:(RouteRepository *)routeRepository;
@end
