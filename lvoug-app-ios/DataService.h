#import <Foundation/Foundation.h>
#import "Article.h"
#import "Event.h"
#import "APIClient.h"
#import "DBClient.h"
#import "JSONConverter.h"

@interface DataService : NSObject

@property (strong, nonatomic) APIClient *apiClient;
@property (strong, nonatomic) DBClient *dbClient;

// singleton
+ (DataService*)instance;

// get from DB
- (NSArray *)events;
- (NSArray *)articles;
- (Article *)article:(NSNumber *)articleId;
- (Event *)event:(NSNumber *)eventId;

// async load data from webservice
- (void)syncData;
- (void)forceSyncData:(NSDate *)lastUpdateDate;

// get from user storage
- (void)storeLastUpdateDate:(NSDate *)date;
- (NSDate *)getLastUpdateDate;

- (void)storeLastLogoutDate:(NSDate *)date;
- (NSDate *)getLastLogoutDate; // unused


@end
