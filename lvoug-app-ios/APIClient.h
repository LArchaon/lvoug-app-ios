#import <Foundation/Foundation.h>

@interface APIClient : NSObject

@property (strong, nonatomic) NSMutableArray *news;
@property (strong, nonatomic) NSMutableArray *events;

// singleton
+ (APIClient*)instance;

// get data from cache or load from webservice if cache is empty
- (NSMutableArray *)events;
- (NSMutableArray *)news;

- (NSDictionary *)article:(NSString *)articleId;
- (NSDictionary *)event:(NSString *)eventId;

// force data load from webservice
- (void)reloadNews;
- (void)reloadEvents;

@end
