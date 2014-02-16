#import "APIClient.h"

static APIClient* _restClient = nil;

@implementation APIClient

+(APIClient*)restClient {
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

// force reload
- (void)reloadNews
{
    _news = [[NSMutableArray alloc]init];
    
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:@"http://lvoug-webservice.herokuapp.com/api/articles"];
    NSString *json = [NSString stringWithContentsOfURL:url
                                              encoding:NSASCIIStringEncoding
                                                 error:&error];
    
    if(!error) {
        NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:kNilOptions
                                                                   error:&error];
        
        NSArray *articles = [jsonDict objectForKey:@"articles"];
        
        for (id object in articles) {
            [_news addObject:object];
        }
        
        NSLog(@"JSON: %@", jsonDict);
    }
    
    // todo if error maybe send error message in result and display it on screen
}

@end
