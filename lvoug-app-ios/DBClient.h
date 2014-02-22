#import <Foundation/Foundation.h>

#import "Event.h"
#import "Contact.h"
#import "Material.h"
#import "Sponsor.h"
#import "Article.h"

@interface DBClient : NSObject

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id)initWithContext:(NSManagedObjectContext *)nsManagedObjectContext;

- (NSArray *)getEvents;
- (NSArray *)getArticles;

- (void)removeExistingObject:(NSManagedObject *)object;

- (Article *)createArticle;
- (Event *)createEvent;
- (Material *)createMaterial;
- (Sponsor *)createSponsor;
- (Contact *)createContact;

- (void)saveAll;

@end
