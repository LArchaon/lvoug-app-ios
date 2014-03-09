#import "APIClient.h"

@implementation APIClient

- (NSArray *)getArticles:(NSDate *)fetchFromDate
{
    NSString *url;
    if (fetchFromDate == nil) {
        url = @"http://lvoug-webservice.herokuapp.com/api/articles";
    } else {
        NSMutableString *s1 = [NSMutableString init];
        [s1 appendString:@"http://lvoug-webservice.herokuapp.com/api/articles?from="];
        [s1 appendString:[NSString stringWithFormat:@"%f", [fetchFromDate timeIntervalSince1970]]];
        url = s1;
    }

    NSDictionary *list = [self getDataFromUrl:url];
    NSArray *articles = [list objectForKey:@"articles"];
    return articles;
}

- (NSArray *)getEvents:(NSDate *)fetchFromDate
{
    NSString *url;
    if (fetchFromDate == nil) {
        url = @"http://lvoug-webservice.herokuapp.com/api/events";
    } else {
        NSMutableString *s1 = [NSMutableString init];
        [s1 appendString:@"http://lvoug-webservice.herokuapp.com/api/events?from="];
        [s1 appendString:[NSString stringWithFormat:@"%f", [fetchFromDate timeIntervalSince1970]]];
        url = s1;
    }
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
    
    [NSException raise:@"Webservice error" format:@"webservice error"];
    return [[NSDictionary init] alloc];
}

@end
