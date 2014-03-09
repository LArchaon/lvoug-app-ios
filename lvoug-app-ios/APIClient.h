#import <Foundation/Foundation.h>

@interface APIClient : NSObject

- (NSArray *)getEvents:(NSDate *)fetchFromDate;
- (NSArray *)getArticles:(NSDate *)fetchFromDate;

@end
