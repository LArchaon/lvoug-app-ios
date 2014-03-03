#import "DateHelper.h"

@implementation DateHelper

+(NSString *)getDateTimeFromApiFormat:(NSString *)sDate
{
    return [self getFormat:@"dd.MM.yyyy HH:mm" fromApiFormat:sDate];
}

+(NSString *)getDateFromApiFormat:(NSString *)sDate
{
    return [self getFormat:@"dd.MM.yyyy" fromApiFormat:sDate];
}

+(NSString *)getFormat:(NSString *)format fromApiFormat:(NSString *)dateString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *dateFromString = [dateFormat dateFromString:dateString];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:dateFromString];
}


+(NSString *)getDateTimeFromUnixtime:(NSString *)sDate
{
    return [self getFormat:@"dd.MM.yyyy HH:mm" fromUnixtime:sDate];
}

+(NSString *)getDateFromUnixtime:(NSString *)sDate
{
    return [self getFormat:@"dd.MM.yyyy" fromUnixtime:sDate];
}

+(NSString *)getFormat:(NSString *)format fromUnixtime:(NSString *)sDate
{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[sDate intValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

@end
