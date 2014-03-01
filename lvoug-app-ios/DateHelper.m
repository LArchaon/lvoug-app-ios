#import "DateHelper.h"

@implementation DateHelper

+(NSString *)getDateFromUnixtime:(NSString *)sDate
{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[sDate intValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    return newDate;
}

@end
