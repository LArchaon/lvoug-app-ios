#import "APIClient.h"
#import "OUGAppDelegate.h"

#import "Event.h"
#import "Contact.h"
#import "Material.h"
#import "Sponsor.h"
#import "Article.h"

static APIClient* _restClient = nil;

@implementation APIClient


+ (APIClient*)instance
{
    if (_restClient == nil) {
        _restClient = [[APIClient alloc] init];
        OUGAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        _restClient.managedObjectContext = appDelegate.managedObjectContext;
    }
    
    return _restClient;
}

- (NSArray *)articles
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (NSMutableArray *)events
{
    if (_events == nil) {
        [self reloadEvents];
    }
    return _events;
}

- (Article *)article:(NSNumber *)articleId
{
    NSArray *articles = [self articles];
    for (Article *article in articles) {
        if (article.id == articleId)
            return article;
    }
    return nil;
}

- (NSDictionary *)event:(NSString *)eventId
{
    NSArray *events = [self events];
    for (NSDictionary *article in events) {
        if ([article objectForKey:@"id"] == eventId)
            return article;
    }
    return nil;
}

- (void)reloadArticles
{
    _articles = [[NSArray alloc]init];
    
    NSString *url = @"http://lvoug-webservice.herokuapp.com/api/articles";
    NSDictionary *list = [self getDataFromUrl:url];
    NSArray *articles = [list objectForKey:@"articles"];
    
    for (id article in articles) {
        NSManagedObject * articleId = [self article:[article objectForKey:@"id"]];
        if (articleId != nil) {
            [self.managedObjectContext deleteObject:articleId];
        }
        
        Article * newArticle = [NSEntityDescription insertNewObjectForEntityForName:@"Article"
                                                          inManagedObjectContext:self.managedObjectContext];
        newArticle.id = [article objectForKey:@"id"];
        newArticle.title = [article objectForKey:@"title"];
        newArticle.text = [article objectForKey:@"description"];
        newArticle.image = [article objectForKey:@"image"];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

- (void)reloadEvents
{
    _events = [[NSMutableArray alloc]init];
    
    NSString *url = @"http://lvoug-webservice.herokuapp.com/api/events";
    
    NSDictionary *list = [self getDataFromUrl:url];
    NSArray *articles = [list objectForKey:@"events"];
        
    for (id object in articles) {
        [_events addObject:object];
    }
}

- (NSDictionary *)getDataFromUrl:(NSString *)stringUrl
{
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSString *json = [NSString stringWithContentsOfURL:url
                                              encoding:NSASCIIStringEncoding
                                                 error:&error];
    if(!error) {
        NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:kNilOptions
                                                                   error:&error];
        return jsonDict;
    }
    
    return [[NSDictionary init] alloc];
}

@end
