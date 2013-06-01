@interface Route : NSObject
- (id)initWithIdentifier:(NSString *)identifier coordinates:(NSArray *)coordinates;
- (NSString *)firstToLastName;

@property (strong, nonatomic, readonly) NSString *identifier;
@property (strong, nonatomic, readonly) NSArray *coordinates;
@property (strong, nonatomic, readwrite) NSArray *spaces;
@end
