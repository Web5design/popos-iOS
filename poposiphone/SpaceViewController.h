#import <UIKit/UIKit.h>
#import "Space.h"

@interface SpaceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *foodIcon;
- (id)initWithSpace:(Space *)space;
@end
