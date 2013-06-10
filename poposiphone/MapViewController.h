#import <UIKit/UIKit.h>
#import "SpaceRepository.h"
#import "RouteRepository.h"
#import "MapBox.h"

@interface MapViewController : UIViewController <RMMapViewDelegate>
@property (strong, nonatomic, readonly) SpaceRepository *spaceRepository;

- (id)initWithSpaceRepository:(SpaceRepository *)spaceRepository routeRepository:(RouteRepository *)routeRepository;
@end
