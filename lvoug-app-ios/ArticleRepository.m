#import "ArticleRepository.h"

@implementation ArticleRepository

- (ArticleRepository *)initWithDbClient:(DBClient *)db
{
    self.dbClient = db;
    return self;
}

- (Boolean)updateAll:(NSArray *)eventsFromApi
{
    for (id article in eventsFromApi) {
        [self.dbClient removeExistingObject:[self get:[article objectForKey:@"id"]]];
        Article * newArticle = (Article *)[self.dbClient createDbObject:@"Article"];
        [JSONConverter constructArticle:newArticle fromJson:article];
        [self.dbClient saveAll];
    }
    
    if (eventsFromApi.count == 0)
        return FALSE;
    else
        return TRUE;
}

- (NSArray *)getAll
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [self.dbClient getQueryObject:@"Article"];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortByIdDesc = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    [fetchRequest setSortDescriptors:[[NSArray alloc] initWithObjects:sortByIdDesc, nil]];
    
    return [self.dbClient getResult:fetchRequest];
}

- (Article *)get:(NSNumber *)articleId
{
    NSArray *articles = [self getAll];
    for (Article *article in articles) {
        if ([article.id intValue] == [articleId intValue])
            return article;
    }
    return nil;
}

@end
