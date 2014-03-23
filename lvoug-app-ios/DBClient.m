#import "DBClient.h"

@implementation DBClient

- (id)initWithContext:(NSManagedObjectContext *)nsManagedObjectContext
{
    self.managedObjectContext = nsManagedObjectContext;
    return self;
}

- (NSEntityDescription *)getQueryObject:(NSString *)className
{
    NSEntityDescription * entity = [NSEntityDescription entityForName:className
                                               inManagedObjectContext:self.managedObjectContext];
    return entity;
}

- (NSManagedObject *)createDbObject:(NSString *)className
{
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:className
                                                            inManagedObjectContext:self.managedObjectContext];
    return object;
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
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    return result;
}

- (void)saveAll
{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

- (void)lock
{
    [self.managedObjectContext lock];
}

- (void)unlock
{
    [self.managedObjectContext unlock];
}

@end
