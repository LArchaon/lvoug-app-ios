#import "APIClient.h"

static APIClient* _restClient = nil;

@implementation APIClient

+ (APIClient*)instance
{
    if (_restClient == nil) {
        _restClient = [[APIClient alloc] init];
    }
    
    return _restClient;
}

- (NSMutableArray *)news
{
    if (_news == nil) {
        [self reloadNews];
    }
    return _news;
}

- (NSMutableArray *)events
{
    if (_events == nil) {
        [self reloadEvents];
    }
    return _events;
}

- (NSDictionary *)article:(NSString *)articleId
{
    NSArray *news = [self news];
    for (NSDictionary *article in news) {
        if ([article objectForKey:@"id"] == articleId)
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

- (void)reloadNews
{
    _news = [[NSMutableArray alloc]init];

    NSString *url = @"http://lvoug-webservice.herokuapp.com/api/articles";
    
    NSDictionary *list = [self getDataFromUrl:url];
    NSArray *articles = [list objectForKey:@"articles"];
    
    for (id object in articles) {
        [_news addObject:object];
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
