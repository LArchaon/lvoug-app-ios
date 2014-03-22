#import "DBClient.h"

@implementation DBClient

- (id)initWithContext:(NSManagedObjectContext *)nsManagedObjectContext
{
    self.managedObjectContext = nsManagedObjectContext;
    return self;
}

- (NSEntityDescription *)getQueryObject:(NSString *)className
{
    [self.managedObjectContext lock];
    NSEntityDescription * entity = [NSEntityDescription entityForName:className
                                               inManagedObjectContext:self.managedObjectContext];
    [self.managedObjectContext unlock];
    return entity;
}

- (NSManagedObject *)createDbObject:(NSString *)className
{
    [self.managedObjectContext lock];
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:className
                                                            inManagedObjectContext:self.managedObjectContext];
    [self.managedObjectContext unlock];
    return object;
}

- (void)removeExistingObject:(NSManagedObject *)object
{
    if (object != nil) {
        NSLog(@"removing existing object");
        [self.managedObjectContext lock];
        [self.managedObjectContext deleteObject:object];
        [self.managedObjectContext unlock];
        NSLog(@"removed");
    }
}

- (NSArray *)getResult:(NSFetchRequest *)request
{
    NSError* error;
    [self.managedObjectContext lock];
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    [self.managedObjectContext unlock];
    return result;
}

- (void)saveAll
{
    NSError *error;
    [self.managedObjectContext lock];
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self.managedObjectContext unlock];
}

@end
