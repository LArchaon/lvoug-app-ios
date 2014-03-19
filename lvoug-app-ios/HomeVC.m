#import "HomeVC.h"
#import "DataService.h"

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Article *newestArticle = [[DataService instance] newestArticle];
    Event *upcomingEvent = [[DataService instance] upcomingEvent];
    
    // todo add info to view
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshView)
                                                 name:@"articlesUpdated"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshView)
                                                 name:@"eventsUpdated"
                                               object:nil];
}

@end