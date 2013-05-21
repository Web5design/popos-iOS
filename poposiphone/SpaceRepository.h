#import "Space.h"

@interface SpaceRepository : NSObject
@property (strong, nonatomic, readonly) NSArray *spaces;

- (void)populateFromGeoJSONFile:(NSString *)pathToFile;
@end
