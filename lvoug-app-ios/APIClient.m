#import "APIClient.h"

@implementation APIClient

- (NSArray *)getArticles
{
    NSString *url = @"http://lvoug-webservice.herokuapp.com/api/articles";
    NSDictionary *list = [self getDataFromUrl:url];
    NSArray *articles = [list objectForKey:@"articles"];
    return articles;
}

- (NSArray *)getEvents
{
    NSString *url = @"http://lvoug-webservice.herokuapp.com/api/events";
    NSDictionary *list = [self getDataFromUrl:url];
    NSArray *events = [list objectForKey:@"events"];
    return events;
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
