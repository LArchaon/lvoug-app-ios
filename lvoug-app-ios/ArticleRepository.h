#import <Foundation/Foundation.h>
#import "Article.h"
#import "DBClient.h"
#import "JSONConverter.h"

@interface ArticleRepository : NSObject

@property (strong, nonatomic) DBClient *dbClient;

- (ArticleRepository *)initWithDbClient:(DBClient *)db;
- (Boolean)updateAll:(NSArray *)articlesFromApi;
- (Article *)get:(NSNumber *)articleId;
- (NSArray *)getAll;

@end
