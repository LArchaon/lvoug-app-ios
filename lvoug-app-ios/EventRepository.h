#import <Foundation/Foundation.h>
#import "Event.h"
#import "DBClient.h"
#import "JSONConverter.h"

@interface EventRepository : NSObject

@property (strong, nonatomic) DBClient *dbClient;

- (EventRepository *)initWithDbClient:(DBClient *)db;
- (Boolean)updateAll:(NSArray *)eventsFromApi;
- (Event *)get:(NSNumber *)eventId;
- (NSArray *)getAllWithOffset:(NSUInteger)offset andLimit:(NSUInteger)limit;
- (Event *)getUpcoming;

@end
