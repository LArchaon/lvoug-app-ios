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
        [self.dbClient lock];
        
        NSLog(@"Updating article - removing existing object");
        Article *oldArticle = [self get:[article objectForKey:@"id"]];
        NSLog(@"Existing object:");
        if (oldArticle == nil) NSLog(@"nil"); else NSLog(oldArticle.title);
        [self.dbClient removeExistingObject:oldArticle];
        NSLog(@"Updating article - creating new object");
        Article * newArticle = (Article *)[self.dbClient createDbObject:@"Article"];
        [JSONConverter constructArticle:newArticle fromJson:article];
        NSLog(@"Updating article - saving");
        [self.dbClient saveAll];
        
        [self.dbClient unlock];
    }
    
    NSLog(@"article DB update done");
    
    if (eventsFromApi.count == 0)
        return FALSE;
    else
        return TRUE;
}

- (NSArray *)getAll
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSSortDescriptor *sortByIdDesc = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    [fetchRequest setSortDescriptors:[[NSArray alloc] initWithObjects:sortByIdDesc, nil]];
    
    [fetchRequest setFetchLimit:10];
    
    [self.dbClient lock];
    NSEntityDescription *entity = [self.dbClient getQueryObject:@"Article"];
    [fetchRequest setEntity:entity];
    NSArray *result = [self.dbClient getResult:fetchRequest];
    [self.dbClient unlock];
    
    return result;
}

- (Article *)get:(NSNumber *)articleId
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"id == %@", articleId];
    [fetchRequest setPredicate:predicate];
    
    [self.dbClient lock];
    NSEntityDescription *entity = [self.dbClient getQueryObject:@"Article"];
    [fetchRequest setEntity:entity];
    NSArray * result = [self.dbClient getResult:fetchRequest];
    [self.dbClient unlock];
    
    if (result.count == 0)
        return nil;
    else
        return [result objectAtIndex:0];
}

- (Article *)getNewest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSSortDescriptor *sortByIdDesc = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    [fetchRequest setSortDescriptors:[[NSArray alloc] initWithObjects:sortByIdDesc, nil]];
    
    [self.dbClient lock];
    NSEntityDescription *entity = [self.dbClient getQueryObject:@"Article"];
    [fetchRequest setEntity:entity];
    NSArray * result = [self.dbClient getResult:fetchRequest];
    [self.dbClient unlock];
    
    if (result.count == 0)
        return nil;
    else
        return [result objectAtIndex:0];
}

@end
