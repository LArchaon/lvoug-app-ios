#import <Foundation/Foundation.h>
#import "Article.h"
#import "Event.h"
#import "APIClient.h"
#import "APIClientMock.h"
#import "JSONConverter.h"
#import "EventRepository.h"
#import "ArticleRepository.h"

@interface DataService : NSObject

@property (strong, nonatomic) APIClient *apiClient;
@property (strong, nonatomic) EventRepository *eventRepository;
@property (strong, nonatomic) ArticleRepository *articleRepository;

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
- (void)storeLastLogoutDate:(NSDate *)date;
- (NSDate *)getLastLogoutDate; // unused

- (Article *)newestArticle;
- (Event *)upcomingEvent;


@end
