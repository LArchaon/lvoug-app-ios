#import "HomeVC.h"
#import "DataService.h"
#import "EventVC.h"
#import "ArticleVC.h"

@implementation HomeVC

NSNumber *event;
NSNumber *article;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshView)
                                                 name:@"articlesUpdated"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshView)
                                                 name:@"eventsUpdated"
                                               object:nil];
    
    Article *newestArticle = [[DataService instance] newestArticle];
    Event *upcomingEvent = [[DataService instance] upcomingEvent];
    
    if (newestArticle != nil) {
        self.latestArticle.textLabel.text = newestArticle.title;
        article = newestArticle.id;
        [self.latestArticle setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self.latestArticle setUserInteractionEnabled:TRUE];
    } else {
        self.latestArticle.textLabel.text = @"Loading...";
        [self.latestArticle setAccessoryType:UITableViewCellAccessoryNone];
        [self.latestArticle setUserInteractionEnabled:FALSE];
    }
    
    if (upcomingEvent != nil) {
        self.latestEvent.textLabel.text = upcomingEvent.title;
        event = upcomingEvent.id;
        [self.latestEvent setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self.latestEvent setUserInteractionEnabled:TRUE];
    } else {
        self.latestEvent.textLabel.text = @"No upcoming event.";
        [self.latestEvent setAccessoryType:UITableViewCellAccessoryNone];
        [self.latestEvent setUserInteractionEnabled:FALSE];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openEvent"]) {
        [segue.destinationViewController setEvent: event];
    }
    
    if ([segue.identifier isEqualToString:@"openArticle"]) {
        [segue.destinationViewController setArticle: article];
    }
}

@end