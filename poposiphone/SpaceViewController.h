#import <UIKit/UIKit.h>
#import "Space.h"

@interface SpaceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (id)initWithSpace:(Space *)space;
@end
