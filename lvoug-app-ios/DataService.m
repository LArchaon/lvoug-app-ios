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
        _dataService.apiClient = [[NSClassFromString([[self getConfig] objectForKey:@"apiClient"]) alloc] init];
    }
    
    return _dataService;
}

- (NSArray *)articles
{
    NSUInteger limit = (NSUInteger)[[[DataService getConfig] objectForKey:@"articleListItemCount"] integerValue];
    return [self.articleRepository getAllWithOffset:0 andLimit:limit];
}

- (NSArray *)events
{
    NSUInteger limit = (NSUInteger)[[[DataService getConfig] objectForKey:@"eventListItemCount"] integerValue];
    return [self.eventRepository getAllWithOffset:0 andLimit:limit];
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
    if (lastDate == nil || timeDiff > [[[DataService getConfig] objectForKey:@"apiRefreshTimeoutInSeconds"] integerValue]) {
        [self forceSyncData:lastDate];
    }
}

- (void)forceSyncData:(NSDate *)lastUpdateDate {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    DataService *service = self;
    
    dispatch_queue_t myQueue = dispatch_queue_create("API Sync Queue",NULL);
    dispatch_async(myQueue, ^{
        NSLog(@"In queue");
        Boolean articlesUpdated = FALSE;
        Boolean eventsUpdated = FALSE;
        
        NSString *alertTitle;
        NSString *alertText;
        
        @try {
            NSLog(@"Updating articles");
            articlesUpdated = [service reloadArticles:lastUpdateDate];
            NSLog(@"Updating events");
            eventsUpdated = [service reloadEvents:lastUpdateDate];
            NSLog(@"Updating upadte date");
            [service storeLastUpdateDate:[NSDate date]];
            NSLog(@"finish");
        }
        @catch (NSException *exception) {
            NSLog(@"Exception on sync");
            if (lastUpdateDate == nil) {
                alertTitle = @"No network connection";
                alertText = @"You must be connected to the internet to use this app.";
            } else {
                alertTitle = @"No network connection";
                alertText = @"Internet connection needed to load new data.";
            }
        }
        NSLog(@"Before ui change");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Sync finish, updating ui");
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            if (alertTitle != nil && alertText != nil) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                                message:alertText
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
            } else {
                
                if (eventsUpdated) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"eventsUpdated" object:nil];
                }
                
                if (articlesUpdated) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"articlesUpdated" object:nil];
                }
                
            }
            NSLog(@"UI update end");
        });
    });
}

- (Boolean)reloadArticles:(NSDate *)lastUpdateDate
{
    NSLog(@"Calling api articles");
    NSArray *articles = [self.apiClient getArticles:lastUpdateDate];
    NSLog(@"Syncing articles with db");
    [self.articleRepository updateAll:articles];
    NSLog(@"D articles B sync finish");
    if (articles.count == 0)
        return FALSE;
    else
        return TRUE;
}

- (Boolean)reloadEvents:(NSDate *)lastUpdateDate
{
    NSLog(@"Calling api events");
    NSArray *events = [self.apiClient getEvents:lastUpdateDate];
    NSLog(@"Syncing events with db");
    [self.eventRepository updateAll:events];
    NSLog(@"events DB sync finish");
    if (events.count == 0)
        return FALSE;
    else
        return TRUE;
}

- (void)storeLastLogoutDate:(NSDate *)date
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"kLastCloseDate"];
}

- (NSDate *)getLastLogoutDate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"kLastCloseDate"];
}

- (void)storeLastUpdateDate:(NSDate *)date
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"kLastUpdateDate"];
}

- (NSDate *)getLastUpdateDate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"kLastUpdateDate"];
}

static NSMutableArray *menuItems;
static NSMutableDictionary *configItems;

+ (NSArray *)getMenuItems
{
    if (menuItems == nil) {
        menuItems = [[NSMutableArray alloc]init];
        [menuItems addObject:@{@"title":@"Home", @"img":@"ico_home.png", @"controllerId": @"homeVC"}];
        [menuItems addObject:@{@"title":@"News", @"img":@"ico_news.png", @"controllerId": @"articlesVC"}];
        [menuItems addObject:@{@"title":@"Events", @"img":@"ico_events.png", @"controllerId": @"eventsVC"}];
        [menuItems addObject:@{@"title":@"About", @"img":@"ico_about.png", @"controllerId": @"aboutVC"}];
    }
    
    return menuItems;
}

+ (NSDictionary *)getConfig
{
    if (configItems == nil) {
        configItems = [[NSMutableDictionary alloc] init];
        
        [configItems setObject:@"lvoug" forKey:@"facebook"];
        [configItems setObject:@"lvoug" forKey:@"twitter"];
        [configItems setObject:@"LvougLv" forKey:@"gplus"];
        [configItems setObject:[[NSNumber alloc] initWithUnsignedInt:7] forKey:@"eventListItemCount"];
        [configItems setObject:[[NSNumber alloc] initWithUnsignedInt:10] forKey:@"articleListItemCount"];
        
        // change before deploy
        [configItems setObject:@"APIClient" forKey:@"apiClient"]; // set APIClient
        [configItems setObject:[[NSNumber alloc] initWithInt:1] forKey:@"apiRefreshTimeoutInSeconds"]; // set 3600
    }
    
    return configItems;
}

@end
