#import "EventRepository.h"

@implementation EventRepository

-(EventRepository *)initWithDbClient:(DBClient *)db
{
    self.dbClient = db;
    return self;
}

- (Boolean)updateAll:(NSArray *)eventsFromApi
{
    for (id event in eventsFromApi) {
        // todo check if all associated objects removed when event is deleted.
        [self.dbClient removeExistingObject:[self get:[event objectForKey:@"id"]]];
        Event * newEvent = (Event *)[self.dbClient createDbObject:@"Event"];
        [JSONConverter constructEvent:newEvent fromJson:event];
        
        NSArray *materials = [event objectForKey:@"event_materials"];
        NSMutableArray *newMaterials = [[NSMutableArray alloc] init];
        for (id material in materials) {
            Material *newMaterial = (Material *)[self.dbClient createDbObject:@"Material"];
            [JSONConverter constructMaterial:newMaterial fromJson:material];
            [newMaterials addObject:newMaterial];
        }
        newEvent.eventMaterials = [NSSet setWithArray:newMaterials];
        
        NSArray *contacts = [event objectForKey:@"contacts"];
        NSMutableArray *newContacts = [[NSMutableArray alloc] init];
        for (id contact in contacts) {
            Contact *newContact = (Contact *)[self.dbClient createDbObject:@"Contact"];
            [JSONConverter constructContact:newContact fromJson:contact];
            [newContacts addObject:newContact];
        }
        newEvent.eventContacts = [NSSet setWithArray:newContacts];
        
        NSArray *sponsors = [event objectForKey:@"sponsors"];
        NSMutableArray *newSponsors = [[NSMutableArray alloc] init];
        for (id sponsor in sponsors) {
            Sponsor *newSponsor = (Sponsor *)[self.dbClient createDbObject:@"Sponsor"];
            [JSONConverter constructSponsor:newSponsor fromJson:sponsor];
            [newSponsors addObject:newSponsor];
        }
        newEvent.eventSponsors = [NSSet setWithArray:newSponsors];
        
        [self.dbClient saveAll];
    }
    
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
    
    return [self.dbClient getResult:fetchRequest];
}

- (Event *)get:(NSNumber *)eventId;
{
    NSArray *events = [self getAll];
    for (Event *event in events) {
        if ([event.id intValue] == [eventId intValue])
            return event;
    }
    return nil;
}



@end
