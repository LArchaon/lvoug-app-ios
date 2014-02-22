#import <Foundation/Foundation.h>
#import "Article.h"

@interface APIClient : NSObject

@property (strong, nonatomic) NSArray *articles;
@property (strong, nonatomic) NSMutableArray *events;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


// singleton
+ (APIClient*)instance;

// get data from cache or load from webservice if cache is empty
- (NSMutableArray *)events;
- (NSArray *)articles;

- (Article *)article:(NSNumber *)articleId;
- (NSDictionary *)event:(NSString *)eventId;

// force data load from webservice
- (void)reloadArticles;
- (void)reloadEvents;

@end
