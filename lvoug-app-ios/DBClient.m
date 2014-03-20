#import "DBClient.h"

@implementation DBClient

- (id)initWithContext:(NSManagedObjectContext *)nsManagedObjectContext
{
    self.managedObjectContext = nsManagedObjectContext;
    return self;
}

- (NSEntityDescription *)getQueryObject:(NSString *)className
{
    return [NSEntityDescription entityForName:className
                       inManagedObjectContext:self.managedObjectContext];
}

- (NSManagedObject *)createDbObject:(NSString *)className
{
    return [NSEntityDescription insertNewObjectForEntityForName:className
                                         inManagedObjectContext:self.managedObjectContext];
}

- (void)removeExistingObject:(NSManagedObject *)object
{
    if (object != nil) {
        NSLog(@"removing existing object");
        [self.managedObjectContext deleteObject:object];
        NSLog(@"removed");
    }
}

- (NSArray *)getResult:(NSFetchRequest *)request
{
    NSError* error;
    return [self.managedObjectContext executeFetchRequest:request error:&error];
}

- (void)saveAll
{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

@end
