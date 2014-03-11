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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"id == %@", articleId];
    [fetchRequest setPredicate:predicate];
    
    NSEntityDescription *entity = [self.dbClient getQueryObject:@"Article"];
    [fetchRequest setEntity:entity];

    NSArray * result = [self.dbClient getResult:fetchRequest];
    
    if (result.count == 0)
        return nil;
    else
        return [result objectAtIndex:0];
}

@end
