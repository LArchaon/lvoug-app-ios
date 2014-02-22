#import <Foundation/Foundation.h>
#import "Article.h"
#import "Event.h"
#import "APIClient.h"
#import "DBClient.h"
#import "JSONConverter.h"

@interface DataService : NSObject

@property (strong, nonatomic) APIClient *apiClient;
@property (strong, nonatomic) DBClient *dbClient;

- (NSArray *)events;
- (NSArray *)articles;

// singleton
+ (DataService*)instance;

- (Article *)article:(NSNumber *)articleId;
- (Event *)event:(NSNumber *)eventId;

// force data load from webservice
- (void)reloadArticles;
- (void)reloadEvents;

@end
