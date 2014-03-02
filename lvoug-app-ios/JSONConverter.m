#import "JSONConverter.h"
#import "Event.h"
#import "Contact.h"
#import "Material.h"
#import "Sponsor.h"
#import "Article.h"

@implementation JSONConverter

+(void)constructEvent:(Event *)event fromJson:(NSDictionary *)json
{
    event.id = [json objectForKey:@"id"];
    event.title = [json objectForKey:@"title"];
    event.text = [json objectForKey:@"description"];
    event.logo = [json objectForKey:@"logo"];
    event.address = [json objectForKey:@"address"];
    event.address_latitude = [json objectForKey:@"address_latitude"];
    event.address_longitude = [json objectForKey:@"address_longitude"];
    event.event_page = [json objectForKey:@"event_page"];
    event.date = [json objectForKey:@"event_date"];
}

+(void)constructArticle:(Article *)article fromJson:(NSDictionary *)json
{
    article.id = [json objectForKey:@"id"];
    article.title = [json objectForKey:@"title"];
    article.text = [json objectForKey:@"description"];
    article.image = [json objectForKey:@"image"];
    article.date = [json objectForKey:@"created_at"];
}

+(void)constructSponsor:(Sponsor *)sponsor fromJson:(NSDictionary *)json
{
    sponsor.id = [json objectForKey:@"id"];
    sponsor.name = [json objectForKey:@"name"];
    sponsor.image = [json objectForKey:@"image"];
}

+(void)constructMaterial:(Material *)material fromJson:(NSDictionary *)json
{
    material.id = [json objectForKey:@"id"];
    material.title = [json objectForKey:@"title"];
    material.url = [json objectForKey:@"url"];
}

+(void)constructContact:(Contact *)contact fromJson:(NSDictionary *)json
{
    contact.id = [json objectForKey:@"id"];
    contact.name = [json objectForKey:@"name"];
    contact.surname = [json objectForKey:@"surname"];
    contact.telephone = [json objectForKey:@"telephone"];
    contact.email = [json objectForKey:@"email"];
}

@end
