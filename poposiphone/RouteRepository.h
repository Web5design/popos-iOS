#import "Route.h"
#import "SpaceRepository.h"

@interface RouteRepository : NSObject
@property (strong, nonatomic, readonly) NSArray *routes;
- (void)populateFromGeoJSONFile:(NSString *)pathToFile;

// Attach spaces onto individual routes, since we don't otherwise have this association
- (void)addSpaces:(SpaceRepository *)spaceRepository;
@end
