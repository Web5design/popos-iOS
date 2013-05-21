#import "Route.h"

@interface RouteRepository : NSObject
@property (strong, nonatomic, readonly) NSArray *routes;
- (void)populateFromGeoJSONFile:(NSString *)pathToFile;
@end
