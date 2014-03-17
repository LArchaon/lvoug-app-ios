#import "HomeVC.h"
#import "DataService.h"

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITextView *uiText = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    Article *newestArticle = [[DataService instance] newestArticle];
    Event *upcomingEvent = [[DataService instance] upcomingEvent];
    if (upcomingEvent != nil) {
        
        uiText.text = @"Upcoming event";
    } else if (newestArticle != nil) {
        uiText.text = @"Newest article";
    } else {
        uiText.text = @"Loading data from the internets...";
    }
    
    self.view = uiText;
}

@end