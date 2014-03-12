#import "HomeVC.h"
#import "DataService.h"

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // todo if data in db, show it
    
    // else show text 
    UITextView *uiText = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    uiText.text = @"Loading data from the internets...";
    self.view = uiText;
    
    
    /*
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    
    UIButton *refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    [refreshButton setTitle:@"titl1" forState:UIControlStateNormal];
    
    self.view = indicator;
     */
}

@end
