@interface Route : NSObject
- (id)initWithIdentifier:(NSString *)identifier coordinates:(NSArray *)coordinates;

@property (strong, nonatomic, readonly) NSString *identifier;
@property (strong, nonatomic, readonly) NSArray *coordinates;
@end
