#import <Foundation/Foundation.h>

@interface NavigationHelper : NSObject

+ (void)openUrl:(NSString *)url;

+ (void)openTwitter:(NSString *)username;
+ (void)openFacebook:(NSString *)username;
+ (void)openGooglePlus:(NSString *)username;

+ (void)openMail:(NSString *)email;
+ (void)call:(NSString *)number;

@end
