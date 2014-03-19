#import "DataService.h"
#import "OUGAppDelegate.h"
#import "HomeVC.h"
#import "ArticlesVC.h"
#import "EventsVC.h"

static DataService *_dataService = nil;

@implementation DataService

+ (DataService*)instance
{
    if (_dataService == nil) {
        _dataService = [[DataService alloc] init];
        OUGAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        DBClient * dbClient = [[DBClient alloc] initWithContext:appDelegate.managedObjectContext];
        _dataService.articleRepository = [[ArticleRepository alloc] initWithDbClient:dbClient];
        _dataService.eventRepository = [[EventRepository alloc] initWithDbClient:dbClient];
        //_dataService.apiClient = [[APIClient alloc] init];
        _dataService.apiClient = [[APIClientMock alloc] init];
    }
    
    return _dataService;
}

- (NSArray *)articles
{
    return [self.articleRepository getAll];
}

- (NSArray *)events
{
    return [self.eventRepository getAll];
}

- (Article *)article:(NSNumber *)articleId
{
    return [self.articleRepository get:articleId];
}

- (Event *)event:(NSNumber *)eventId
{
    return [self.eventRepository get:eventId];
}

- (Event *)upcomingEvent
{
    return [self.eventRepository getUpcoming];
}

- (Article *)newestArticle
{
    return [self.articleRepository getNewest];
}

- (void)syncData {
    NSDate *lastDate = [[DataService instance] getLastUpdateDate];
    NSTimeInterval timeDiff = [[NSDate date] timeIntervalSinceDate:lastDate];
    if (lastDate == nil || timeDiff > (60 * 60)) {
        [self forceSyncData:lastDate];
    }
}

- (void)forceSyncData:(NSDate *)lastUpdateDate {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        Boolean articlesUpdated = FALSE;
        Boolean eventsUpdated = FALSE;
        
        @try {
            articlesUpdated = [self reloadArticles:lastUpdateDate];
            eventsUpdated = [self reloadEvents:lastUpdateDate];
            [self storeLastUpdateDate:[NSDate date]];
        }
        @catch (NSException *exception) {
            NSString *alertTitle;
            NSString *alertText;
            
            if (lastUpdateDate == nil) {
                alertTitle = @"No network connection";
                alertText = @"You must be connected to the internet to use this app.";
            } else {
                alertTitle = @"No network connection";
                alertText = @"Internet connection needed to load new data.";
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                            message:alertText
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        @finally {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }

             
        if (eventsUpdated) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"eventsUpdated" object:nil];
        }
        
        if (articlesUpdated) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"articlesUpdated" object:nil];
        }
        
    });
}

- (Boolean)reloadArticles:(NSDate *)lastUpdateDate
{
    NSArray *articles = [self.apiClient getArticles:lastUpdateDate];

    [self.articleRepository updateAll:articles];
    
    if (articles.count == 0)
        return FALSE;
    else
        return TRUE;
}

- (Boolean)reloadEvents:(NSDate *)lastUpdateDate
{
    NSArray *events = [self.apiClient getEvents:lastUpdateDate];
    
    [self.eventRepository updateAll:events];

    if (events.count == 0)
        return FALSE;
    else
        return TRUE;
}

- (void)storeLastLogoutDate:(NSDate *)date {
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"kLastCloseDate"];
}

- (NSDate *)getLastLogoutDate {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"kLastCloseDate"];
}

- (void)storeLastUpdateDate:(NSDate *)date {
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"kLastUpdateDate"];
}

- (NSDate *)getLastUpdateDate {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"kLastUpdateDate"];
}

@end
