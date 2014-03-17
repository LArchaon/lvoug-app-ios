#import "AboutVC.h"

@implementation AboutVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.aboutFacebook setUserInteractionEnabled:YES];
    [self.aboutTwitter setUserInteractionEnabled:YES];
    [self.aboutGoogle setUserInteractionEnabled:YES];
    
    [self.aboutFacebook addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openFacebook)]];
    [self.aboutTwitter addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openTwitter)]];
    [self.aboutGoogle addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openGooglePlus)]];
}

- (void)openFacebook
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://facebook.com/lvoug"]];
}

- (void)openTwitter
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://twitter.com/lvoug"]];
}

- (void)openGooglePlus
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://plus.google.com/+LvougLv/posts"]];
}

@end
