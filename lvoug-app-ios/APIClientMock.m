#import "APIClientMock.h"
#import "DateHelper.h"

@implementation APIClientMock

- (NSDictionary *)getDataFromUrl:(NSString *)stringUrl
{
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
    
    if ([stringUrl isEqualToString:@"http://lvoug-webservice.herokuapp.com/api/articles"]) {
        NSMutableArray *articles = [[NSMutableArray alloc] init];
        
        [articles addObject:[self getArticleMock:[[NSNumber alloc] initWithInt:1]]];
        [articles addObject:[self getArticleMock:[[NSNumber alloc] initWithInt:2]]];
        [articles addObject:[self getArticleMock:[[NSNumber alloc] initWithInt:3]]];
        [articles addObject:[self getArticleMock:[[NSNumber alloc] initWithInt:4]]];
        [articles addObject:[self getArticleMock:[[NSNumber alloc] initWithInt:5]]];
        [articles addObject:[self getArticleMock:[[NSNumber alloc] initWithInt:6]]];
        
        [data setValue:articles forKey:@"articles"];
    }
    
    if ([stringUrl isEqualToString:@"http://lvoug-webservice.herokuapp.com/api/events"]) {
        NSMutableArray *events = [[NSMutableArray alloc] init];
        
        [events addObject:[self getEventMock:[[NSNumber alloc] initWithInt:1]]];
        [events addObject:[self getEventMock:[[NSNumber alloc] initWithInt:2]]];
        [events addObject:[self getEventMock:[[NSNumber alloc] initWithInt:3]]];
        [events addObject:[self getEventMock:[[NSNumber alloc] initWithInt:4]]];
        [events addObject:[self getEventMock:[[NSNumber alloc] initWithInt:5]]];
        [events addObject:[self getEventMock:[[NSNumber alloc] initWithInt:6]]];
        
        [data setValue:events forKey:@"events"];
    }
    
    return data;
}

- (NSDictionary *)getArticleMock:(NSNumber *)articleId
{
    NSMutableDictionary *article = [[NSMutableDictionary alloc] init];
    
    [article setObject:articleId forKey:@"id"];
    [article setObject:[self generateTitle] forKey:@"title"];
    [article setObject:[self generateText] forKey:@"description"];
    [article setObject:[self generateImage] forKey:@"image"];
    [article setObject:[self generateDate] forKey:@"created_at"];
     
    return article;
}

- (NSDictionary *)getEventMock:(NSNumber *)eventId
{
    int eventIdInt = [eventId integerValue];
    NSMutableDictionary *event = [[NSMutableDictionary alloc] init];
    
    [event setObject:eventId forKey:@"id"];
    [event setObject:[self generateTitle] forKey:@"title"];
    [event setObject:[self generateText] forKey:@"description"];
    [event setObject:[self generateImage] forKey:@"logo"];
    [event setObject:[self generateAddress] forKey:@"address"];
    [event setObject:[self generateUrl] forKey:@"event_page"];
    [event setObject:[self generateDate] forKey:@"event_date"];
    NSArray * coordinates = [self generateCoordinates];
    [event setObject:[coordinates objectAtIndex:0] forKey:@"address_latitude"];
    [event setObject:[coordinates objectAtIndex:1] forKey:@"address_longitude"];
    
    NSMutableArray *materials = [[NSMutableArray alloc] init];
    [materials addObject:[self getMaterialMock:[[NSNumber alloc] initWithInt:(eventIdInt * 100 + 1)]]];
    [materials addObject:[self getMaterialMock:[[NSNumber alloc] initWithInt:(eventIdInt * 100 + 2)]]];
    [materials addObject:[self getMaterialMock:[[NSNumber alloc] initWithInt:(eventIdInt * 100 + 3)]]];
    [event setObject:materials forKey:@"event_materials"];
    
    NSMutableArray *sponsors = [[NSMutableArray alloc] init];
    [sponsors addObject:[self getSponsorMock:[[NSNumber alloc] initWithInt:(eventIdInt * 100 + 1)]]];
    [sponsors addObject:[self getSponsorMock:[[NSNumber alloc] initWithInt:(eventIdInt * 100 + 2)]]];
    [sponsors addObject:[self getSponsorMock:[[NSNumber alloc] initWithInt:(eventIdInt * 100 + 3)]]];
    [event setObject:sponsors forKey:@"sponsors"];
    
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    [contacts addObject:[self getContactMock:[[NSNumber alloc] initWithInt:(eventIdInt * 100 + 1)]]];
    [contacts addObject:[self getContactMock:[[NSNumber alloc] initWithInt:(eventIdInt * 100 + 2)]]];
    [contacts addObject:[self getContactMock:[[NSNumber alloc] initWithInt:(eventIdInt * 100 + 3)]]];
    [event setObject:contacts forKey:@"contacts"];
    
    return event;
}

- (NSDictionary *)getSponsorMock:(NSNumber *)sponsorId
{
    NSMutableDictionary *sponsor = [[NSMutableDictionary alloc] init];
    
    [sponsor setObject:sponsorId forKey:@"id"];
    [sponsor setObject:[self generateImage] forKey:@"image"];
    [sponsor setObject:[self generateTitle] forKey:@"name"];

    return sponsor;
}

- (NSDictionary *)getMaterialMock:(NSNumber *)materialId
{
    NSMutableDictionary *material = [[NSMutableDictionary alloc] init];
    
    [material setObject:materialId forKey:@"id"];
    [material setObject:[self generateTitle] forKey:@"title"];
    [material setObject:[self generateUrl] forKey:@"url"];
    
    return material;
}

- (NSDictionary *)getContactMock:(NSNumber *)contactId
{
    NSMutableDictionary *contact = [[NSMutableDictionary alloc] init];
    
    [contact setObject:contactId forKey:@"id"];
    [contact setObject:[self generateTitle] forKey:@"name"];
    [contact setObject:[self generateTitle] forKey:@"surname"];
    [contact setObject:[self generateEmail] forKey:@"email"];
    [contact setObject:[self generatePhone] forKey:@"telephone"];
    
    return contact;
}

- (NSString *)generateTitle
{
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    [titles addObject:@"This is very very long title with some useful information in it"];
    [titles addObject:@"This is tiny title"];
    return [titles objectAtIndex:arc4random() % [titles count]];
}

- (NSString *)generateText
{
    NSMutableArray *texts = [[NSMutableArray alloc] init];
    [texts addObject:@"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum./nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum./nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum./nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."];
    
    return [texts objectAtIndex:arc4random() % [texts count]];
}

- (NSString *)generateImage
{
    NSMutableArray *images = [[NSMutableArray alloc] init];
    [images addObject:@"http://habrastorage.org/getpro/habr/post_images/526/495/9c2/5264959c2b030a8f6ea7c4e15b6c7f11.jpg"];
    [images addObject:@"http://img.rl0.ru/afisha/720x-/vozduh.afisha.ru/uploads/images/e/c8/ec882fd4f8134439b47298c69662e3c9.jpg"];
    return [images objectAtIndex:arc4random() % [images count]];
}
     
- (NSString *)generateDate
{
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    [dates addObject:[DateHelper getStringApiFormatFromDate:[NSDate date]]];
    [dates addObject:[DateHelper getStringApiFormatFromDate:[NSDate date]]];
    [dates addObject:[DateHelper getStringApiFormatFromDate:[NSDate date]]];
    return [dates objectAtIndex:arc4random() % [dates count]];
}

- (NSString *)generateAddress
{
    NSMutableArray *addresses = [[NSMutableArray alloc] init];
    [addresses addObject:@"Riga, Avotu iela 2 - 4"];
    [addresses addObject:@"Riga, Brivibas iela 200 - 45, Reval Hotel Latvia"];
    [addresses addObject:@"Riga, Latvia, Jurkalnes iela 25/35, Nordic Technology Park"];
    return [addresses objectAtIndex:arc4random() % [addresses count]];
}

- (NSString *)generateUrl
{
    NSMutableArray *urls = [[NSMutableArray alloc] init];
    [urls addObject:@"http://ctco.lv/"];
    [urls addObject:@"http://facebook.com/"];
    [urls addObject:@"http://eventbrite.com/"];
    return [urls objectAtIndex:arc4random() % [urls count]];
}

- (NSArray *)generateCoordinates
{
    NSMutableArray *coords = [[NSMutableArray alloc] init];
    id coord1 = [[NSNumber alloc] initWithDouble:100.00];
    id coord2 = [[NSNumber alloc] initWithDouble:150.00];
    
    [coords addObject:[[NSArray alloc] initWithObjects:coord1, coord2, nil]];
    [coords addObject:[[NSArray alloc] initWithObjects:coord2, coord1, nil]];
    [coords addObject:[[NSArray alloc] initWithObjects:@"null", @"null", nil]];
    
    return [coords objectAtIndex:arc4random() % [coords count]];
}

- (NSString *)generateEmail
{
    NSMutableArray *emails = [[NSMutableArray alloc] init];
    [emails addObject:@"be@live.ru"];
    [emails addObject:@"bekas@inbox.lv"];
    return [emails objectAtIndex:arc4random() % [emails count]];
}

- (NSString *)generatePhone
{
    NSMutableArray *phones = [[NSMutableArray alloc] init];
    [phones addObject:@"28 87 82 39"];
    [phones addObject:@"29 35 35 35"];
    return [phones objectAtIndex:arc4random() % [phones count]];
}
@end
