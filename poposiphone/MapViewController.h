#import <UIKit/UIKit.h>
#import "SpaceRepository.h"
#import <MapBox/RMMapViewDelegate.h>

@interface MapViewController : UIViewController <RMMapViewDelegate>
@property (strong, nonatomic, readonly) SpaceRepository *spaceRepository;

- (id)initWithSpaceRepository:(SpaceRepository *)spaceRepository;
@end
