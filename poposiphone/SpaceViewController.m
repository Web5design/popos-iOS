#import "SpaceViewController.h"

@interface SpaceViewController ()
@property (strong, nonatomic) Space *space;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation SpaceViewController

- (id)initWithSpace:(Space *)space {
    self = [super init];
    if (self) {
        self.space = space;
        self.title = self.space.identifier;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL * url = [NSURL URLWithString:self.space.imageUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse * resp, NSData * data, NSError * error) {
                               UIImage * img = [UIImage imageWithData:data];
                               [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:img waitUntilDone:YES];
                           }];
    
    self.textView.text = self.space.description;
    self.textView.scrollEnabled = YES;
    
    if(self.space.food) {
        self.foodIcon.image = [UIImage imageNamed:@"Food.png"];
    }
}

@end
