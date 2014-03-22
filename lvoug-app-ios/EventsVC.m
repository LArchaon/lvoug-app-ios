#import "EventsVC.h"
#import "DataService.h"
#import "ImageHelper.h"
#import "DateHelper.h"
#import "EventVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "EventListCell.h"

@implementation EventsVC

NSArray * _events;

- (void)viewDidLoad
{
    [super viewDidLoad];

    _events = [[DataService instance] events];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.0-1.0 green:0.0-1.0 blue:0.0-1.0 alpha:0.5f]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshView)
                                                 name:@"eventsUpdated"
                                               object:nil];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_events count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventsCell"];
    
    Event *event = _events[indexPath.row];
    
    cell.eventTitle.text = event.title;
    cell.eventDate.text = [DateHelper getStringDateFromApiFormat:event.date];
    
    [cell.eventImage setImageWithURL:[NSURL URLWithString:event.logo] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openEvent"]) {
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        Event *event = [_events objectAtIndex:ip.row];
        [segue.destinationViewController setEvent: event.id];
    }
}

@end
