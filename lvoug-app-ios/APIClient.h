#import <Foundation/Foundation.h>

@interface APIClient : NSObject

@property (strong, nonatomic) NSMutableArray *news;
@property (strong, nonatomic) NSMutableArray *events;

// singleton
+ (APIClient*)restClient;

// get data from cache or load from webservice if cache is empty
- (NSMutableArray *)events;
- (NSMutableArray *)news;

// force data load from webservice
- (void)reloadNews;
- (void)reloadEvents;

@end
