#import "HomeVC.h"

@implementation HomeVC

- (void)viewDidLoad
{
    // if not data in storage, show "no data loaded"
    [super viewDidLoad];
    
    UITextView *uiText = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    uiText.text = @"ok";
    self.view = uiText;
    
}

@end
