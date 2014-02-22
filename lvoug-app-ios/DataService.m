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
        if (article.id == articleId)
            return article;
    }
    return nil;
}

- (Event *)event:(NSNumber *)eventId
{
    NSArray *events = [self events];
    for (Event *event in events) {
        if (event.id == eventId)
            return event;
    }
    return nil;
}

- (void)reloadArticles
{
    NSArray *articles = [self.apiClient getArticles];
    for (id article in articles) {
        [self.dbClient removeExistingObject:[self article:[article objectForKey:@"id"]]];
        Article * newArticle = [self.dbClient createArticle];
        [JSONConverter constructArticle:newArticle fromJson:article];
        [self.dbClient saveAll];
    }
}

- (void)reloadEvents
{
    NSArray *events = [self.apiClient getEvents];
    for (id event in events) {
        // todo check if all associated objects remove when event is deleted.
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
}


@end
