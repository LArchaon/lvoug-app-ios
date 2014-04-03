#import "HomeVC.h"
#import "DataService.h"
#import "EventVC.h"
#import "ArticleVC.h"
#import "DateHelper.h"

@implementation HomeVC

NSNumber *event;
NSNumber *article;
UITapGestureRecognizer *eventOpenRecognizer;
UITapGestureRecognizer *articleOpenRecognizer;


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
        self.latestArticleTitle.text = newestArticle.title;
        self.latestArticleDate.text = [DateHelper getStringDateFromApiFormat:newestArticle.date];
        
        article = newestArticle.id;
        [self.latestArticle setUserInteractionEnabled:TRUE];
        if (articleOpenRecognizer != nil) {
            [self.latestArticle removeGestureRecognizer:articleOpenRecognizer];
        }
        articleOpenRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openArticle)];
        [self.latestArticle addGestureRecognizer:articleOpenRecognizer];
    } else {
        self.latestArticleTitle.text = @"Loading...";
        self.latestArticleDate.text = nil;
        article = nil;
        [self.latestArticle setUserInteractionEnabled:FALSE];
    }
    
    if (upcomingEvent != nil) {
        self.latestEventTitle.text = upcomingEvent.title;
        self.latestEventDate.text = [DateHelper getStringDateTimeFromApiFormat:upcomingEvent.date];
        event = upcomingEvent.id;
        [self.latestEvent setUserInteractionEnabled:TRUE];
        if (eventOpenRecognizer != nil) {
            [self.latestEvent removeGestureRecognizer:eventOpenRecognizer];
        }
        eventOpenRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openEvent)];
        [self.latestEvent addGestureRecognizer:eventOpenRecognizer];

    } else {
        self.latestEventTitle.text = @"No upcoming event.";
        self.latestEventDate.text = nil;
        self.latestEventArrow.image = nil;
        event = nil;
        [self.latestEvent setUserInteractionEnabled:FALSE];
    }
}

- (void)openArticle
{
    if (article != nil) {
        ArticleVC *viewController = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"articleVC"];
        [viewController setArticle:article];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)openEvent
{
    if (event != nil) {
        EventVC *viewController = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"eventVC"];
        [viewController setEvent: event];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end