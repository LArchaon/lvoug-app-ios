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
        NSLog(@"Updating article - removing existing object");
        Article *oldArticle = [self get:[article objectForKey:@"id"]];
        NSLog(@"Existing object:");
        if (oldArticle == nil) NSLog(@"nil"); else NSLog(oldArticle.title);
        [self.dbClient removeExistingObject:oldArticle];
        NSLog(@"Updating article - creating new object");
        Article * newArticle = (Article *)[self.dbClient createDbObject:@"Article"];
        NSLog(@"Updating article - adding fields to new object");
        [JSONConverter constructArticle:newArticle fromJson:article];
        NSLog(@"Updating article - saving");
        [self.dbClient saveAll];
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
    
    NSEntityDescription *entity = [self.dbClient getQueryObject:@"Article"];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortByIdDesc = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    [fetchRequest setSortDescriptors:[[NSArray alloc] initWithObjects:sortByIdDesc, nil]];
    
    [fetchRequest setFetchLimit:10];
    
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

- (Article *)getNewest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSSortDescriptor *sortByIdDesc = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    [fetchRequest setSortDescriptors:[[NSArray alloc] initWithObjects:sortByIdDesc, nil]];
    
    NSEntityDescription *entity = [self.dbClient getQueryObject:@"Article"];
    [fetchRequest setEntity:entity];
    
    NSArray * result = [self.dbClient getResult:fetchRequest];
    
    if (result.count == 0)
        return nil;
    else
        return [result objectAtIndex:0];
}

@end
