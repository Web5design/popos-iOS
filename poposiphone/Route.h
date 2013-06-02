@interface Route : NSObject
- (id)initWithIdentifier:(NSString *)identifier coordinates:(NSArray *)coordinates miles:(NSString *)miles;
- (NSString *)firstToLastName;

@property (strong, nonatomic, readonly) NSString *identifier;
@property (strong, nonatomic, readonly) NSArray *coordinates;
@property (strong, nonatomic, readwrite) NSArray *spaces;
@property (strong, nonatomic, readwrite) NSString *miles;
@end
