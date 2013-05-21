#import "SpaceViewController.h"

@interface SpaceViewController ()
@property (strong, nonatomic) Space *space;
@end

@implementation SpaceViewController

- (id)initWithSpace:(Space *)space {
    self = [super init];
    if (self) {
        self.space = space;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
