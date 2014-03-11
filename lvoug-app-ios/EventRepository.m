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
    
    if (eventsFromApi.count == 0)
        return FALSE;
    else
        return TRUE;
}

- (NSArray *)getAll
{
    return [self.dbClient getEvents];
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
