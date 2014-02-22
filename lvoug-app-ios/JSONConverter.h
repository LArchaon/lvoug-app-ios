#import <Foundation/Foundation.h>
#import "Event.h"
#import "Contact.h"
#import "Material.h"
#import "Sponsor.h"
#import "Article.h"

@interface JSONConverter : NSObject

+(void)constructEvent:(Event *)event fromJson:(NSDictionary *)json;
+(void)constructArticle:(Article *)article fromJson:(NSDictionary *)json;
+(void)constructSponsor:(Sponsor *)sponsor fromJson:(NSDictionary *)json;
+(void)constructMaterial:(Material *)material fromJson:(NSDictionary *)json;
+(void)constructContact:(Contact *)contact fromJson:(NSDictionary *)json;

@end
