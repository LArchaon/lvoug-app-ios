#import <Foundation/Foundation.h>

@interface APIClient : NSObject

@property (strong, nonatomic) NSMutableArray *news;
- (NSMutableArray *)news;

+(APIClient*)restClient;

@end
