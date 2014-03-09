#import "DataService.h"
#import "OUGAppDelegate.h"

static DataService *_dataService = nil;

@implementation DataService

+ (DataService*)instance
{
    if (_dataService == nil) {
        _dataService = [[DataService alloc] init];
        OUGAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        _dataService.dbClient = [[DBClient alloc] initWithContext:appDelegate.managedObjectContext];
        _dataService.apiClient = [[APIClient alloc] init];
    }
    
    return _dataService;
}

- (NSArray *)articles
{
    return [self.dbClient getArticles];
}

- (NSArray *)events
{
    return [self.dbClient getEvents];
}

- (Article *)article:(NSNumber *)articleId
{
    NSArray *articles = [self articles];
    for (Article *article in articles) {
        if ([article.id intValue] == [articleId intValue])
            return article;
    }
    return nil;
}

- (Event *)event:(NSNumber *)eventId
{
    NSArray *events = [self events];
    for (Event *event in events) {
        if ([event.id intValue] == [eventId intValue])
            return event;
    }
    return nil;
}

- (void)syncData {
    NSDate *lastDate = [[DataService instance] getLastUpdateDate];
    NSTimeInterval timeDiff = [[NSDate date] timeIntervalSinceDate:lastDate];
    if (lastDate == nil || timeDiff > (60 * 60 * 24)) {
        [self forceSyncData:lastDate];
    }
}

- (void)forceSyncData:(NSDate *)lastUpdateDate {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        // todo add "update" icon to status bar
        
        Boolean articlesUpdated = FALSE;
        Boolean eventsUpdated = FALSE;
        
        @try {
            articlesUpdated = [self reloadArticles:lastUpdateDate];
            eventsUpdated = [self reloadEvents:lastUpdateDate];
            [self storeLastUpdateDate:[NSDate date]];
        }
        @catch (NSException *exception) {
            // todo view popup with no internet connection
        }
        
        // todo force view reload if:
        // 1) we are on home screen
        // 2) we are on news list and it was updated
        // 3) we are on events list and it was updated
    });
}

- (Boolean)reloadArticles:(NSDate *)lastUpdateDate
{
    NSArray *articles = [self.apiClient getArticles:lastUpdateDate];
    for (id article in articles) {
        [self.dbClient removeExistingObject:[self article:[article objectForKey:@"id"]]];
        Article * newArticle = [self.dbClient createArticle];
        [JSONConverter constructArticle:newArticle fromJson:article];
        [self.dbClient saveAll];
    }
    
    if (articles.count == 0)
        return FALSE;
    else
        return TRUE;
}

- (Boolean)reloadEvents:(NSDate *)lastUpdateDate
{
    NSArray *events = [self.apiClient getEvents:lastUpdateDate];
    for (id event in events) {
        // todo check if all associated objects removed when event is deleted.
        [self.dbClient removeExistingObject:[self event:[event objectForKey:@"id"]]];
        Event * newEvent = [self.dbClient createEvent];
        [JSONConverter constructEvent:newEvent fromJson:event];
    
        NSArray *materials = [event objectForKey:@"event_materials"];
        NSMutableArray *newMaterials = [[NSMutableArray alloc] init];
        for (id material in materials) {
            Material *newMaterial = [self.dbClient createMaterial];
            [JSONConverter constructMaterial:newMaterial fromJson:material];
            [newMaterials addObject:newMaterial];
        }
        newEvent.eventMaterials = [NSSet setWithArray:newMaterials];
        
        NSArray *contacts = [event objectForKey:@"contacts"];
        NSMutableArray *newContacts = [[NSMutableArray alloc] init];
        for (id contact in contacts) {
            Contact *newContact = [self.dbClient createContact];
            [JSONConverter constructContact:newContact fromJson:contact];
            [newContacts addObject:newContact];
        }
        newEvent.eventContacts = [NSSet setWithArray:newContacts];
        
        NSArray *sponsors = [event objectForKey:@"sponsors"];
        NSMutableArray *newSponsors = [[NSMutableArray alloc] init];
        for (id sponsor in sponsors) {
            Sponsor *newSponsor = [self.dbClient createSponsor];
            [JSONConverter constructSponsor:newSponsor fromJson:sponsor];
            [newSponsors addObject:newSponsor];
        }
        newEvent.eventSponsors = [NSSet setWithArray:newSponsors];
        
        [self.dbClient saveAll];
    }
    
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
