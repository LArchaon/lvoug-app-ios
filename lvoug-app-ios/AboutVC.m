#import "AboutVC.h"
#import "NavigationHelper.h"
#import "DataService.h"

@implementation AboutVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.aboutFacebook addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openFacebook)]];
    [self.aboutTwitter addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openTwitter)]];
    [self.aboutGoogle addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openGooglePlus)]];
}

- (void)openFacebook
{
    [NavigationHelper openFacebook:[[DataService getConfig] objectForKey:@"facebook"]];
}

- (void)openTwitter
{
    [NavigationHelper openFacebook:[[DataService getConfig] objectForKey:@"twitter"]];
}

- (void)openGooglePlus
{
    [NavigationHelper openFacebook:[[DataService getConfig] objectForKey:@"gplus"]];
}

@end
