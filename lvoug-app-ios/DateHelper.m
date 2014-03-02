#import "DateHelper.h"

@implementation DateHelper

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
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    return newDate;
}

@end
