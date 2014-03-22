#import "EventRepository.h"
#import "DateHelper.h"

@implementation EventRepository

- (EventRepository *)initWithDbClient:(DBClient *)db
{
    self.dbClient = db;
    return self;
}

- (Boolean)updateAll:(NSArray *)eventsFromApi
{
    for (id event in eventsFromApi) {
        NSLog(@"got event");
        // todo check if all associated objects removed when event is deleted.
        NSLog(@"remove existing event");
        [self.dbClient removeExistingObject:[self get:[event objectForKey:@"id"]]];
        NSLog(@"create new event");
        Event * newEvent = (Event *)[self.dbClient createDbObject:@"Event"];
        NSLog(@"add values to event");
        [JSONConverter constructEvent:newEvent fromJson:event];
        NSLog(@"add materials");
        NSArray *materials = [event objectForKey:@"event_materials"];
        NSMutableArray *newMaterials = [[NSMutableArray alloc] init];
        for (id material in materials) {
            Material *newMaterial = (Material *)[self.dbClient createDbObject:@"Material"];
            [JSONConverter constructMaterial:newMaterial fromJson:material];
            [newMaterials addObject:newMaterial];
        }
        newEvent.eventMaterials = [NSSet setWithArray:newMaterials];
        NSLog(@"add contacts");
        NSArray *contacts = [event objectForKey:@"contacts"];
        NSMutableArray *newContacts = [[NSMutableArray alloc] init];
        for (id contact in contacts) {
            Contact *newContact = (Contact *)[self.dbClient createDbObject:@"Contact"];
            [JSONConverter constructContact:newContact fromJson:contact];
            [newContacts addObject:newContact];
        }
        newEvent.eventContacts = [NSSet setWithArray:newContacts];
        NSLog(@"add sponsors");
        NSArray *sponsors = [event objectForKey:@"sponsors"];
        NSMutableArray *newSponsors = [[NSMutableArray alloc] init];
        for (id sponsor in sponsors) {
            Sponsor *newSponsor = (Sponsor *)[self.dbClient createDbObject:@"Sponsor"];
            [JSONConverter constructSponsor:newSponsor fromJson:sponsor];
            [newSponsors addObject:newSponsor];
        }
        newEvent.eventSponsors = [NSSet setWithArray:newSponsors];
        NSLog(@"event save");
        [self.dbClient saveAll];
    }
    
    NSLog(@"event DB update done");
    
    if (eventsFromApi.count == 0)
        return FALSE;
    else
        return TRUE;
}

- (NSArray *)getAll
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [self.dbClient getQueryObject:@"Event"];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortByIdDesc = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    [fetchRequest setSortDescriptors:[[NSArray alloc] initWithObjects:sortByIdDesc, nil]];
    
    [fetchRequest setFetchLimit:7];
    
    return [self.dbClient getResult:fetchRequest];
}

- (Event *)get:(NSNumber *)eventId;
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"id == %@", eventId];
    [fetchRequest setPredicate:predicate];
    
    NSEntityDescription *entity = [self.dbClient getQueryObject:@"Event"];
    [fetchRequest setEntity:entity];
    
    NSArray * result = [self.dbClient getResult:fetchRequest];
    
    if (result.count == 0)
        return nil;
    else
        return [result objectAtIndex:0];
}

- (Event *)getUpcoming
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSSortDescriptor *sortByDateDesc = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:[[NSArray alloc] initWithObjects:sortByDateDesc, nil]];
    
    NSEntityDescription *entity = [self.dbClient getQueryObject:@"Event"];
    [fetchRequest setEntity:entity];
    
    NSArray * result = [self.dbClient getResult:fetchRequest];
    
    if (result.count == 0)
        return nil;

    NSDate *now = [NSDate date];
    Event *latestEvent = [result objectAtIndex:0];
    NSTimeInterval interval = [now timeIntervalSinceDate: [DateHelper getDateFromApiFormat:latestEvent.date]];
    
    if (interval < 0) {
        return latestEvent;
    } else {
        return nil;
    }
}

@end
