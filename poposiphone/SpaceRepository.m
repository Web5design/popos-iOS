#import "SpaceRepository.h"
#import "Space.h"

@interface SpaceRepository ()
@property (strong, nonatomic, readwrite) NSArray *spaces;
@end

@implementation SpaceRepository

- (id)init {
    self = [super init];
    if (self) {
        self.spaces = @[];
    }
    return self;
}

- (void)populateFromGeoJSONFile:(NSString *)pathToFile {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *jsonFile = [resourcePath stringByAppendingPathComponent:pathToFile];
    NSData *data = [NSData dataWithContentsOfFile:jsonFile];
    NSError *charError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&charError];
    
    NSMutableArray *tempSpaces = [NSMutableArray array];
    
    for (NSDictionary *spaceDict in dict[@"features"]) {
        [tempSpaces addObject:[SpaceRepository spaceFromGeoJSON:spaceDict]];
    }
    
    self.spaces = tempSpaces;
}

+ (Space *)spaceFromGeoJSON:(NSDictionary *)json {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([json[@"geometry"][@"coordinates"][1] floatValue],[json[@"geometry"][@"coordinates"][0] floatValue]);
    return [[Space alloc] initWithIdentifier:json[@"id"] coordinate:coordinate imageUrl:json[@"properties"][@"pic_file"]];
}

@end
