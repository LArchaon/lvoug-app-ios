#import "NavigationHelper.h"

@implementation NavigationHelper

+ (void)openUrl:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
}

+ (void)openTwitter:(NSString *)username
{
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"twitter://user?id=", username]]];
    
    if (canOpen) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"twitter://user?id=", username]]];
    } else {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"https://www.twitter.com/", username]];
        [[UIApplication sharedApplication] openURL:url];
    }
}

+ (void)openFacebook:(NSString *)username
{
    NSString *url = [NSString stringWithFormat:@"%@%@", @"http://facebook.com/", username];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (void)openGooglePlus:(NSString *)username
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@", @"https://plus.google.com/+", username, @"/posts"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
}

+ (void)openMail:(NSString *)email
{
    NSString *url = [NSString stringWithFormat:@"%@%@", @"mailto:", email];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (void)call:(NSString *)number
{
    NSMutableString *phone = [number mutableCopy];
    
    [phone replaceOccurrencesOfString:@" "
                           withString:@""
                              options:NSLiteralSearch
                                range:NSMakeRange(0, [phone length])];
    [phone replaceOccurrencesOfString:@"("
                           withString:@""
                              options:NSLiteralSearch
                                range:NSMakeRange(0, [phone length])];
    [phone replaceOccurrencesOfString:@")"
                           withString:@""
                              options:NSLiteralSearch
                                range:NSMakeRange(0, [phone length])];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]];
    
    [[UIApplication sharedApplication] openURL:url];
}

@end
