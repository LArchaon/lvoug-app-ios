#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

+ (NSString *)getStringDateFromUnixtime:(NSString *)sDate;
+ (NSString *)getStringDateTimeFromUnixtime:(NSString *)sDate;

+ (NSString *)getStringDateTimeFromApiFormat:(NSString *)sDate;
+ (NSString *)getStringDateFromApiFormat:(NSString *)sDate;

+ (NSString *)getStringApiFormatFromDate:(NSDate *)date;

+ (NSDate *)getDateFromApiFormat:(NSString *)sDate;

@end
