#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

+ (NSString *)getDateFromUnixtime:(NSString *)sDate;
+ (NSString *)getDateTimeFromUnixtime:(NSString *)sDate;

+ (NSString *)getDateTimeFromApiFormat:(NSString *)sDate;
+ (NSString *)getDateFromApiFormat:(NSString *)sDate;

@end
