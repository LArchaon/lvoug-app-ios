#import "EventsVC.h"
#import "DataService.h"
#import "ImageHelper.h"
#import "DateHelper.h"
#import "EventVC.h"

@interface EventsVC ()

@end

@implementation EventsVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *eventList = [[DataService instance] events];
    
    for (id event in eventList) {
        [self.events addObject:event];
    }
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.0-1.0 green:0.0-1.0 blue:0.0-1.0 alpha:0.5f]];
}

-(NSMutableArray*)events
{
    if (_events == nil) {
        _events = [[NSMutableArray alloc]init];
    }
    return _events;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.events count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"eventsCell"];
    
    Event *event = self.events [indexPath.row];
    
    cell.textLabel.text = event.title;
    cell.detailTextLabel.text = [DateHelper getDateFromApiFormat:event.date];
    
    /* uncomment to add event image to event list
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: event.logo]];
    cell.imageView.image = [ImageHelper imageWithImage:[UIImage imageWithData: imageData] scaledToSize:CGSizeMake(40.0, 40.0)];
    */
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openEvent"]) {
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        Event *event = [self.events objectAtIndex:ip.row];
        [segue.destinationViewController setEvent: event.id];
    }
}

@end
