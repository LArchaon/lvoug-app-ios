#import <UIKit/UIKit.h>
#import "MFSideMenuContainerViewController.h"

@interface OUGAppDelegate : UIResponder <UIApplicationDelegate>

@property (weak, nonatomic) IBOutlet UITextView *articleTitle;
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (UIViewController *)getCurrentVC;
- (void)reloadCurrentView;

@end


