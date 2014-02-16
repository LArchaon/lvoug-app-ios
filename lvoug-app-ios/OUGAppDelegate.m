#import "OUGAppDelegate.h"
#import "MFSideMenuContainerViewController.h"

@implementation OUGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]];
    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController *) self.window.rootViewController;
    
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"leftSideMenuViewController"];
    
    leftSideMenuViewController
    
    [container setLeftMenuViewController:leftSideMenuViewController];
    [container setCenterViewController:navigationController];
    
    return YES;
}
@end
