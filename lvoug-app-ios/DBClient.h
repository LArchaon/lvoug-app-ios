#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DBClient : NSObject

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id)initWithContext:(NSManagedObjectContext *)nsManagedObjectContext;

- (NSManagedObject *)createDbObject:(NSString *)className;
- (void)removeExistingObject:(NSManagedObject *)object;
- (NSEntityDescription *)getQueryObject:(NSString *) className;
- (NSArray *)getResult:(NSFetchRequest *)request;
- (void)saveAll;

- (void)unlock;
- (void)lock;

@end
