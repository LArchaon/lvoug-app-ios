#import "OUGAppDelegate.h"
#import "MFSideMenuContainerViewController.h"
#import "APIClient.h"

@implementation OUGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]];
    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController *) self.window.rootViewController;
    
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"leftSideMenuViewController"];
    
    [container setLeftMenuViewController:leftSideMenuViewController];
    [container setCenterViewController:navigationController];
    
    // mb block screen here?
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        // load everything on startup
        id client = [APIClient restClient];
        [client news];
        
        /*
        dispatch_sync(dispatch_get_main_queue(), ^{
            mb unblock screen here?
        });
         */
    });
    
    return YES;
}
@end
