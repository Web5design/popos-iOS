#import <UIKit/UIKit.h>
#import "Space.h"

@interface SpaceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
- (id)initWithSpace:(Space *)space;
@end
