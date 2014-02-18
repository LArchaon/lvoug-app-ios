#import "EventVC.h"
#import "APIClient.h"

@interface EventVC ()

@end

@implementation EventVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *event = [[APIClient instance] event:_chosenEvent];
    
    self.eventTitle.text = [event objectForKey:@"title"];
    self.eventText.text = [event objectForKey:@"description"];
}

-(void)setEvent:(NSString *)eventId
{
    _chosenEvent = eventId;
}

@end
