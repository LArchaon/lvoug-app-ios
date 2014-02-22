#import "DBClient.h"

#import "Event.h"
#import "Contact.h"
#import "Material.h"
#import "Sponsor.h"
#import "Article.h"

@implementation DBClient

- (id)initWithContext:(NSManagedObjectContext *)nsManagedObjectContext
{
    self.managedObjectContext = nsManagedObjectContext;
    return self;
}

- (NSArray *)getArticles
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (NSArray *)getEvents
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (void)removeExistingObject:(NSManagedObject *)object
{
    if (object != nil) {
        [self.managedObjectContext deleteObject:object];
    }
}

- (Article *)createArticle
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Article"
                                  inManagedObjectContext:self.managedObjectContext];
}

- (Event *)createEvent
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Event"
                                         inManagedObjectContext:self.managedObjectContext];
}

- (Material *)createMaterial
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Material"
                                         inManagedObjectContext:self.managedObjectContext];
}

- (Sponsor *)createSponsor
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Sponsor"
                                         inManagedObjectContext:self.managedObjectContext];
}

- (Contact *)createContact
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Contact"
                                         inManagedObjectContext:self.managedObjectContext];
}

- (void)saveAll
{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

@end
