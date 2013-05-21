@interface Route : NSObject
- (id)initWithCoordinates:(NSArray *)coordinates;

@property (strong, nonatomic, readonly) NSArray *coordinates;
@end
