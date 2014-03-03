#import "HomeVC.h"
#import "DataService.h"

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
    
    UITextView *uiText = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    uiText.text = @"Please, push the refresh button";
    self.view = uiText;
    /*
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    
    UIButton *refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    [refreshButton setTitle:@"titl1" forState:UIControlStateNormal];
    
    self.view = indicator;
     */
}

- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        id client = [DataService instance];
        [client reloadArticles];
        [client reloadEvents];
    });
}

@end
